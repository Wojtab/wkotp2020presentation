#include "chartdatagen.h"
#include <QXYSeries>

ChartDataGen::ChartDataGen(QObject *parent) : QObject(parent)
{

}

void ChartDataGen::generate(QtCharts::QAbstractSeries *series, QJSValue f, double to, double step)
{
    QVector<QPointF> points;
    for(double c = 0; c < to; c+=step)
    {
        points.push_back({c, f.call(QJSValueList() << QJSValue(c)).toNumber()});
    }
    QtCharts::QXYSeries *xySeries = static_cast<QtCharts::QXYSeries *>(series);
    xySeries->replace(points);
}
