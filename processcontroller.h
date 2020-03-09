#ifndef PROCESSCONTROLLER_H
#define PROCESSCONTROLLER_H

#include <QObject>
#include <QAbstractSeries>
#include <QProcess>
#include <QUrl>

class ProcessController : public QObject
{
    Q_OBJECT
    Q_PROPERTY(float xmin READ xmin NOTIFY xminChanged)
    Q_PROPERTY(float xmax READ xmax NOTIFY xmaxChanged)
    Q_PROPERTY(float ymin READ ymin NOTIFY yminChanged)
    Q_PROPERTY(float ymax READ ymax NOTIFY ymaxChanged)
public:
    explicit ProcessController(QObject *parent = nullptr);

    float xmin() const
    {
        return m_xmin;
    }

    float xmax() const
    {
        return m_xmax;
    }

    float ymin() const
    {
        return m_ymin;
    }

    float ymax() const
    {
        return m_ymax;
    }

public slots:
    void update(QtCharts::QAbstractSeries *series);
    void setProcess(const QUrl& url);
    void start(const QString& pname="", bool demoOnly=false);
    void stopAxes(bool stop=true);
    void stop();

signals:
    void xminChanged();
    void xmaxChanged();
    void yminChanged();
    void ymaxChanged();

private:
    QVector<QPointF> m_data;
    QProcess* m_process = nullptr;
    QUrl m_processUrl;
    float m_xmin = 0;
    float m_xmax;
    float m_ymin;
    float m_ymax;
    bool m_updateAxes=true;
};

#endif // PROCESSCONTROLLER_H
