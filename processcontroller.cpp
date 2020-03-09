#include "processcontroller.h"
#include <QXYSeries>
#include <QDebug>

ProcessController::ProcessController(QObject *parent) : QObject(parent)
{

}

void ProcessController::update(QtCharts::QAbstractSeries *series)
{
    if (series)
    {
        QtCharts::QXYSeries *xySeries = static_cast<QtCharts::QXYSeries *>(series);
        xySeries->replace(m_data);
    }
}

void ProcessController::setProcess(const QUrl &url)
{
    m_processUrl = url;
}

void ProcessController::start(const QString &pname, bool demoOnly)
{
    if(pname==""&&!m_processUrl.isLocalFile()) return;
    if(m_process)
    {
        if(m_process->state() == QProcess::Running)
            return;
    }
    else
    {
        m_process = new QProcess();
    }
    m_data.clear();
    if(m_updateAxes)
    {
        m_xmin = 0;
        m_xmax = 1000;
        m_ymin = 100000000000.;
        m_ymax = -100000000000.;
        emit xminChanged();
        emit xmaxChanged();
    }

    m_process->setProgram(pname==""?m_processUrl.toLocalFile():pname);
    if(demoOnly)
    {
        m_process->start();
        return;
    }
    m_process->setReadChannel(QProcess::ProcessChannel::StandardOutput);
    m_process->setProcessChannelMode(QProcess::MergedChannels);
    /*connect(process, QOverload<int, QProcess::ExitStatus>::of(&QProcess::finished),
            this, [this, process](int a, QProcess::ExitStatus b)
    {
        process->deleteLater();
    });*/
    connect(m_process, &QProcess::readyReadStandardOutput, this, [this](){
        while(m_process->canReadLine())
        {
            QString line(m_process->readLine());
            bool isok = false;
            float val = line.trimmed().toFloat(&isok);
            if(!isok) return;
            if(m_updateAxes)
            {
                if(m_xmax < m_data.size())
                {
                    m_xmax = m_data.size();
                    emit xmaxChanged();
                }
            }
            if(m_ymin > val){
                m_ymin = val - 1;
                emit yminChanged();
            }
            if(m_ymax < val){
                m_ymax = val + 1;
                emit ymaxChanged();
            }
            m_data.append({(float)m_data.size(), line.trimmed().toFloat()});
        }
    });
    m_process->start();
    //m_process = process;
}

void ProcessController::stopAxes(bool stop)
{
    m_updateAxes = !stop;
}

void ProcessController::stop()
{
    m_process->terminate();
}
