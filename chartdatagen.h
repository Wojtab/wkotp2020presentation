#ifndef CHARTDATAGEN_H
#define CHARTDATAGEN_H

#include <QObject>
#include <QAbstractSeries>
#include <QJSValue>

class ChartDataGen : public QObject
{
    Q_OBJECT
public:
    ChartDataGen(QObject* parent=nullptr);
public slots:
    void generate(QtCharts::QAbstractSeries *series, QJSValue f, double to, double step);
};

#endif // CHARTDATAGEN_H
