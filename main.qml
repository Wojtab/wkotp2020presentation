import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Particles 2.14
import QtGraphicalEffects 1.0
import QtCharts 2.12
import QtQuick.Controls 2.14

Window {
    id: root
    visible: true
    width: 1280
    height: 720
    property var sc: height/720
    property var current: 0
    onCurrentChanged: console.log(current)
    title: qsTr("Presentation")
    MouseArea {
        id: mouseHandler
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton
        property bool drawEnable: false
        onDrawEnableChanged: {
            if(!drawEnable)
            {
                draw.clear()
            }
        }

        onClicked: {
            if(drawEnable) return
            if(mouse.button == Qt.LeftButton) root.current += 1
            else root.current -= 1
            mouse.accepted = true
        }
        pressAndHoldInterval: 2000
        onPressAndHold: {
            if(drawEnable) return
            root.visibility = root.visibility == Window.FullScreen ? Window.Windowed : Window.FullScreen
        }
        onPressed: {
            if(drawEnable) {
                draw.lx=mouseX
                draw.ly=mouseY
            }
        }
        onPositionChanged: if(drawEnable) draw.requestPaint()
    }
    Item {
        anchors.fill: parent
        focus: true

        Item {
            id: slide1
            anchors.fill: parent
            visible: root.current < 2
            property var start: 0
            Item {
                anchors.fill: parent
                id: holder1

                Column {
                    anchors.centerIn: parent
                    spacing: 16*sc
                    Text {
                        id: mainText
                        text: "Computer simulations of particle-based systems"
                        font.pixelSize: 50*sc
                    }
                    Text {
                        horizontalAlignment: Text.AlignHCenter
                        width: mainText.width
                        text: "Wojciech Bacza"
                        font.pixelSize: 35*sc
                    }
                    Text {
                        horizontalAlignment: Text.AlignHCenter
                        width: mainText.width
                        text: "University of Wrocław"
                        font.pixelSize: 25*sc
                    }
                }
            }

            ParticleSystem {
                visible: running
                id: ps
                running: root.current == slide1.start+1
                anchors.fill: parent
                onRunningChanged: reset()
            }
            ItemParticle {
                system: ps
                delegate:
                    Item {
                        id: se
                        width: 80; height: 80
                        visible: ps.running
                    Rectangle {
                        visible: true
                        id: serect
                        width: 60; height: 60
                        color: "#30c0c0ff"
                        radius: 40
                    }
                    GaussianBlur {
                        width: 60
                        height: 60
                        anchors.centerIn: parent
                        source: ShaderEffectSource {
                                                sourceItem: holder1
                                                sourceRect: Qt.rect(se.x+10, se.y+10, 60, 60)
                                                live: true
                                            }
                        radius: 10
                        samples: 30
                    }
                }
            }

            Emitter {
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.top: parent.top
                lifeSpan: 5000
                maximumEmitted: 150
                emitRate: 20
                system: ps
                size: 8
                acceleration: PointDirection {y:100; yVariation: 50}
            }
        }
        Item {
            id: slide2
            anchors.fill: parent
            property var start: 2
            visible: root.current >=start && root.current < 7
            Text {
                id: title2
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "What are particle-based systems?"
                font.pixelSize: 50*sc
            }/*
            Image {
                source: "http://i.upmath.me/svg/f(x)"
            }*/
            Column {
                anchors.top: title2.bottom
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                Text {
                    text: "- Material point systems"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide2.start+1
                }
                Text {
                    text: "- Interactions"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide2.start+2
                }
                Text {
                    text: "- Local behavior"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide2.start+3
                }
                Text {
                    text: "- Global behavior"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide2.start+4
                }
            }
        }
        Item {
            id: slide3
            anchors.fill: parent
            property var start: 7
            visible: root.current >=start && root.current < 21
            Text {
                id: title3
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Simulations"
                font.pixelSize: 50*sc
            }
            Column {
                anchors.top: title3.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current < slide3.start+13
                Text {
                    text: "- Why?"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide3.start+1
                }
                Text {
                    text: "- Analitycal solution"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide3.start+2
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                    Rectangle {
                        visible: root.current >=slide3.start+3
                        anchors.left: parent.left
                        anchors.right: parent.right
                        anchors.rightMargin: -8*sc
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.verticalCenterOffset: 3*sc
                        height: 4*sc
                        color: "#e03030"
                        radius: 50
                    }
                }
                Text {
                    text: "- Numerical solution"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide3.start+4
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Item {
                    width: parent.width
                    height: interactionsT.height
                    Text {
                        id: modelT
                        text: "- Model"
                        font.pixelSize: 35*sc
                        visible: root.current >=slide3.start+5
                    }
                    Image {
                        height: parent.height - 10*sc
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: modelT.verticalCenter
                        anchors.verticalCenterOffset:5
                        source: "http://i.upmath.me/png/%5Cimplies"
                        //sourceSize.height: parent.height - 10*sc
                        width: height * sourceSize.width/sourceSize.height
                        visible: root.current >=slide3.start+12
                        fillMode: Image.Stretch
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "- System of diff. eq."
                            font.pixelSize: 35*sc
                            anchors.left: parent.right
                        }
                    }
                }
                Item {
                    width: parent.width
                    height: interactionsT.height
                    Text {
                        id: interactionsT
                        text: "- Movement & interactions"
                        font.pixelSize: 35*sc
                        visible: root.current >=slide3.start+6
                        anchors.left: parent.left
                        anchors.leftMargin: 50*sc
                    }
                    Image {
                        height: parent.height - 10*sc
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: interactionsT.verticalCenter
                        anchors.verticalCenterOffset:5
                        source: "http://i.upmath.me/png/%5Cimplies"
                        //sourceSize.height: parent.height - 10*sc
                        width: height * sourceSize.width/sourceSize.height
                        visible: root.current >=slide3.start+10
                        fillMode: Image.Stretch
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "- Differential equation"
                            font.pixelSize: 35*sc
                            anchors.left: parent.right
                            anchors.leftMargin: 50*sc
                        }
                    }
                }
                Item {
                    width: parent.width
                    height: pdText.height
                    Text {
                        id: pdText
                        text: "- Particle details"
                        font.pixelSize: 35*sc
                        visible: root.current >=slide3.start+7
                        anchors.left: parent.left
                        anchors.leftMargin: 50*sc
                    }
                    Image {
                        height: parent.height - 10*sc
                        anchors.horizontalCenter: parent.horizontalCenter
                        anchors.verticalCenter: pdText.verticalCenter
                        anchors.verticalCenterOffset:5
                        source: "http://i.upmath.me/png/%5Cimplies"
                        //sourceSize.height: parent.height - 10*sc
                        width: height * sourceSize.width/sourceSize.height
                        visible: root.current >=slide3.start+11
                        fillMode: Image.Stretch
                        Text {
                            anchors.verticalCenter: parent.verticalCenter
                            text: "- Equation coefficients"
                            font.pixelSize: 35*sc
                            anchors.left: parent.right
                            anchors.leftMargin: 50*sc
                        }
                    }
                }
                Text {
                    text: "- Boundary conditions"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide3.start+8
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Initial conditions"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide3.start+9
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }

            }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Numerical solver of a system of differential equations"
                font.pixelSize: 50*sc
                visible: root.current ==slide3.start+13
            }
        }
        Item {
            id: slide4
            property var start: 21
            anchors.fill: parent
            visible: root.current >= start && root.current < start+24
            Text {
                id: title4
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Examples"
                font.pixelSize: 50*sc
                visible: root.current != 30 && root.current != 38
            }
            Column {
                anchors.top: title4.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide4.start+1 && root.current < slide4.start+9
                Text {
                    text: "- Cosmology"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+1
                }
                Text {
                    text: "- Formation and evolution of the unviverse"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+2
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- N-body simulations"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+3
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Gravitational potential"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+4
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Text {
                    text: "- 6N ordinary differential equations"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+5
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Text {
                    text: "- Tree methods"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+6
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Text {
                    text: "- Millenium Run (2005)"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+7
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- 10¹⁰ particles in 2*10⁹ lightyear cube"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+8
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
            }
            Text {
                id: millenium
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.left: parent.left
                anchors.leftMargin: 30*sc
                text: "Millenium run"
                font.pixelSize: 50*sc
                visible: root.current == slide4.start+9
            }
            Image {
                id: posterLarge
                source: "poster_large.jpg"
                anchors.right: parent.right
                anchors.rightMargin: 30*sc
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: height * sourceSize.width/sourceSize.height
                visible: root.current == slide4.start+9
            }
            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30*sc
                anchors.left: parent.left
                anchors.leftMargin: 30*sc
                anchors.right: posterLarge.left
                text: "Springel, V., White, S., Jenkins, A. et al. Simulations of the formation, evolution and clustering of galaxies and quasars. Nature 435, 629–636(2005). https://doi.org/10.1038/nature03597"
                font.pixelSize: 35*sc
                visible: root.current == slide4.start+9
                wrapMode: Text.Wrap
            }

            Column {
                anchors.top: title4.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide4.start+10 && root.current < slide4.start+17
                Text {
                    text: "- Molecular simulations"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+10
                }
                Text {
                    text: "- Behavior of molecules at atomic scale"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+11
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Potential"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+12
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Lennard-Jones(6-12, 12-6) potential"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+13
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/V(r)=%5Cepsilon%5Cleft[%5Cleft(%5Cfrac%7Br_m%7D%7Br%7D%5Cright)%5E%7B12%7D-2%5Cleft(%5Cfrac%7Br_m%7D%7Br%7D%5Cright)%5E6%5Cright]"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide4.start+14
                    fillMode: Image.Stretch
                }

                Text {
                    text: "- Material science"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+15
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Biochemistry"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+16
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
            }
            Text {
                id: virus
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.left: parent.left
                anchors.leftMargin: 30*sc
                text: "Satellite Tobacco\nMosaic Virus"
                font.pixelSize: 50*sc
                visible: root.current == slide4.start+17
            }
            Image {
                id: virusImg
                source: "gr1.jpg"
                anchors.right: parent.right
                anchors.rightMargin: 30*sc
                anchors.top: parent.top
                anchors.bottom: parent.bottom
                width: height * sourceSize.width/sourceSize.height
                visible: root.current == slide4.start+17
            }
            Text {
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 30*sc
                anchors.left: parent.left
                anchors.leftMargin: 30*sc
                anchors.right: virusImg.left
                text: "Peter L. Freddolino, Anton S. Arkhipov et al. Molecular Dynamics Simulations of the Complete Satellite Tobacco Mosaic Virus, Structure, Vol 14, Issue 3, 2006, pp 437-449, https://doi.org/10.1016/j.str.2005.11.014."
                font.pixelSize: 35*sc
                visible: root.current == slide4.start+17
                wrapMode: Text.Wrap
            }
            Column {
                anchors.top: title4.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide4.start+18
                Text {
                    text: "- Plasma simulations"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+18
                }
                Text {
                    text: "- Maxwell's equations"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+19
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Particle in cell"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+20
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Super particles"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+21
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Text {
                    text: "- Eulerian grid"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+22
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
                Text {
                    text: "- Lagrangian frame of reference"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide4.start+23
                    anchors.left: parent.left
                    anchors.leftMargin: 100*sc
                }
            }
        }
        Item {
            id: slide5
            property var start: 45
            anchors.fill: parent
            visible: root.current >= start && root.current < start+8
            Text {
                id: title5
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Working principle"
                font.pixelSize: 50*sc
                visible: root.current >= slide5.start
            }
            Column {
                anchors.top: title5.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide5.start
                Text {
                    text: "- Discretization"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+1
                }
                Text {
                    text: "- Numerical integration"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+2
                }
                Text {
                    text: "- Euler method"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+3
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Verlet integration"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+4
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Runge-Kutta methods"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+5
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                }
                Text {
                    text: "- Particle description (position, velocity, physical quantities)"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+6
                }
                Text {
                    text: "- System description (initial+boundary conditions, interactions)"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide5.start+7
                }
            }
        }
        Item {
            id: slide6
            property var start: 53
            anchors.fill: parent
            visible: root.current >= start && root.current <= slide6.start+7
            Text {
                id: title6
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Euler method"
                font.pixelSize: 50*sc
                visible: root.current >= slide6.start
            }
            Column {
                anchors.top: title6.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide6.start && root.current < slide6.start+5
                Text {
                    text: "- Simplest method"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide6.start+1
                }
                Text {
                    text: "- First order"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide6.start+2
                }
                Text {
                    text: "- Let"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide6.start+3
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/y'(t)=f(t,y)\\;\\;\\;\\;\\;\\;y(t_0)=y_0"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide6.start+3
                    fillMode: Image.Stretch
                }
                Text {
                    text: "- Then"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide6.start+4
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/y_{n+1}=y_n+\\Delta t*f(t_n,y_n)"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide6.start+4
                    fillMode: Image.Stretch
                }
            }

            Image {
                anchors.left: parent.left
                anchors.top: title6.bottom
                anchors.leftMargin: 50*sc
                anchors.topMargin: 50*sc
                source: "http://i.upmath.me/png/y'(t)=y\\;\\;\\;\\;\\;\\;y(0)=1"
                //sourceSize.height: 50*sc
                height: 40*sc
                width: height * sourceSize.width/sourceSize.height
                visible: root.current >=slide6.start+5
                fillMode: Image.Stretch
            }
            Image {
                anchors.left: parent.left
                anchors.top: title6.bottom
                anchors.leftMargin: 50*sc
                anchors.topMargin: 120*sc
                source: "http://i.upmath.me/png/y_{n+1}=y_n+\\Delta t*y_n"
                //sourceSize.height: 50*sc
                height: 40*sc
                width: height * sourceSize.width/sourceSize.height
                visible: root.current >=slide6.start+6
                fillMode: Image.Stretch
            }
            ChartView {
                id: chartView
                anchors.top: title6.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.horizontalCenter
                anchors.right: parent.right
                visible: root.current >=slide6.start+7
                //animationOptions: ChartView.AllAnimations
                ValueAxis {
                    id: valX
                    min: 0
                    max: 5
                }
                ValueAxis {
                    id: valY
                    min: 0
                    max: 20
                }

                LineSeries {
                    id: lineSeries
                    name: "e^x"
                    axisX: valX
                    axisY: valY
                }

                LineSeries {
                    id: lineSeries2
                    name: "e^x euler method"
                    axisX: valX
                    axisY: valY
                }
            }
            Slider {
                visible: root.current >=slide6.start+7
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50*sc
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                id: timestepSlider
                from: 0.0001
                to: 2
                value: 2.0
                onValueChanged: {
                    dataGen.generate(chartView.series(0), function(x){return Math.pow(2.71828, x)}, 5, 0.1)
                    var prevY = 1;
                    dataGen.generate(chartView.series(1), function(x){if(x==0)return 1; prevY = prevY + prevY*value; return prevY}, 7.1, value)
                }
                Component.onCompleted: {
                    dataGen.generate(chartView.series(0), function(x){return Math.pow(2.71828, x)}, 5, 0.1)
                    var prevY = 1;
                    dataGen.generate(chartView.series(1), function(x){if(x==0)return 1; prevY = prevY + prevY*value; return prevY}, 7.1, value)
                }
            }
            TextField {
                visible: root.current >=slide6.start+7
                anchors.bottom: timestepSlider.top
                text: timestepSlider.value.toFixed(5)
            }
        }
        Item {
            id: slide7
            property var start: 61
            anchors.fill: parent
            visible: root.current >= start && root.current < slide7.start+9
            Text {
                id: title7
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Verlet integration"
                font.pixelSize: 50*sc
                visible: root.current >= slide7.start
            }
            Column {
                anchors.top: title7.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide7.start && root.current < slide7.start+6
                Text {
                    text: "- Bit more complicated"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide7.start+1
                }
                Text {
                    text: "- Second order"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide7.start+2
                }
                Text {
                    text: "- Let"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide7.start+3
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/y''(t)=f(y)\\;\\;\\;\\;\\;\\;y(t_0)=y_0\\;\\;\\;\\;\\;\\;y'(t_0)=v_0"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide7.start+3
                    fillMode: Image.Stretch
                }
                Text {
                    text: "- Then"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide7.start+4
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/y_1 = y_0 + v_0\\Delta t + 0.5f(y_0)\\Delta t^2"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide7.start+4
                    fillMode: Image.Stretch
                }
                Image {
                    anchors.horizontalCenter: parent.horizontalCenter
                    source: "http://i.upmath.me/png/y_{n+1} = 2y_n -y_{n-1} + f(y_n)\\Delta t^2"
                    //sourceSize.height: 50*sc
                    height: 40*sc
                    width: height * sourceSize.width/sourceSize.height
                    visible: root.current >=slide7.start+5
                    fillMode: Image.Stretch
                }
            }

            Image {
                anchors.left: parent.left
                anchors.top: title7.bottom
                anchors.leftMargin: 50*sc
                anchors.topMargin: 50*sc
                source: "http://i.upmath.me/png/y''(t)=y,\\;y(0)=y'(0)=1"
                //sourceSize.height: 50*sc
                height: 40*sc
                width: height * sourceSize.width/sourceSize.height
                visible: root.current >=slide7.start+6
                fillMode: Image.Stretch
            }
            Image {
                anchors.left: parent.left
                anchors.top: title7.bottom
                anchors.leftMargin: 50*sc
                anchors.topMargin: 120*sc
                source: "http://i.upmath.me/png/y_{n+1} = 2y_n -y_{n-1} + y_n\\Delta t^2"
                //sourceSize.height: 50*sc
                height: 40*sc
                width: height * sourceSize.width/sourceSize.height
                visible: root.current >=slide7.start+7
                fillMode: Image.Stretch
            }
            ChartView {
                id: chartView2
                anchors.top: title7.bottom
                anchors.bottom: parent.bottom
                anchors.left: parent.horizontalCenter
                anchors.right: parent.right
                visible: root.current >=slide7.start+8
                //animationOptions: ChartView.AllAnimations
                ValueAxis {
                    id: valX2
                    min: 0
                    max: 5
                }
                ValueAxis {
                    id: valY2
                    min: 0
                    max: 20
                }

                LineSeries {
                    id: lineSeries_2
                    name: "e^x"
                    axisX: valX2
                    axisY: valY2
                }

                LineSeries {
                    id: lineSeries22
                    name: "e^x verlet"
                    axisX: valX2
                    axisY: valY2
                }
                LineSeries {
                    id: lineSeries32
                    name: "e^x euler"
                    axisX: valX2
                    axisY: valY2
                }
            }
            Slider {
                visible: root.current >=slide7.start+8
                anchors.bottom: parent.bottom
                anchors.bottomMargin: 50*sc
                anchors.left: parent.left
                anchors.right: parent.horizontalCenter
                id: timestepSlider2
                from: 0.0001
                to: 2
                value: 2.0
                onValueChanged: {
                    dataGen.generate(chartView2.series(0), function(x){return Math.pow(2.71828, x)}, 5, 0.1)
                    var yn = 1 + value;
                    var yn1 = 1;
                    var prevY = 1;
                    dataGen.generate(chartView2.series(1), function(x){if(x==0)return 1;if(x<value*1.5)return 1 + value + 0.5*value*value; var temp = yn; yn = 2*yn - yn1 + yn*value*value; yn1 = temp; return yn}, 7.1, value)
                    dataGen.generate(chartView2.series(2), function(x){if(x==0)return 1; prevY = prevY + prevY*value; return prevY}, 7.1, value)
                }
                Component.onCompleted: {
                    dataGen.generate(chartView2.series(0), function(x){return Math.pow(2.71828, x)}, 5, 0.1)
                    var yn = 1 + value;
                    var yn1 = 1;
                    var prevY = 1;
                    dataGen.generate(chartView2.series(1), function(x){if(x==0)return 1;if(x<value*1.5)return 1 + value + 0.5*value*value; var temp = yn; yn = 2*yn - yn1 + yn*value*value; yn1 = temp; return yn}, 7.1, value)
                    dataGen.generate(chartView2.series(2), function(x){if(x==0)return 1; prevY = prevY + prevY*value; return prevY}, 7.1, value)
                }
            }
            TextField {
                visible: root.current >=slide7.start+8
                anchors.bottom: timestepSlider2.top
                text: timestepSlider2.value.toFixed(5)
            }
        }
        Item {
            id: slide8
            property var start: 70
            anchors.fill: parent
            visible: root.current >= start && root.current < start+8
            Text {
                id: title8
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Challenges"
                font.pixelSize: 50*sc
                visible: root.current >= slide8.start
            }
            Column {
                anchors.top: title8.bottom
                anchors.left: parent.left
                anchors.right: parent.right
                anchors.bottom: parent.bottom
                anchors.margins: 20*sc
                anchors.topMargin: 40*sc
                spacing: 30*sc
                visible: root.current >=slide8.start && root.current < slide8.start+9
                Text {
                    text: "- Energy runaway/creation"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+1
                }
                Text {
                    text: "- Thermostat"
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+3
                }
                Text {
                    text: "- Accuracy"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+4
                }
                Text {
                    text: "- Varying timestep"
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+5
                }
                Text {
                    text: "- Better integrator"
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+6
                }
                Text {
                    text: "- Computational complexity"
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+7
                }
                Text {
                    text: "- Optimisation"
                    anchors.left: parent.left
                    anchors.leftMargin: 50*sc
                    font.pixelSize: 35*sc
                    visible: root.current >=slide8.start+8
                }
            }
            Rectangle {
                id: energy
                anchors.fill: parent
                visible: root.current ==slide8.start+2
                property bool isFast: true
                Text {
                    id: titlesub
                    anchors.top: parent.top
                    anchors.topMargin: 30*sc
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: "Energy runaway/creation"
                    font.pixelSize: 50*sc
                    visible: root.current >= slide6.start
                }
                Column{
                    anchors.top: titlesub.top
                    anchors.topMargin: 30*sc
                Button {
                    text: "0.005"
                    onClicked: {
                        energy.isFast = true
                        controller.stopAxes(false)
                        controller.start("fast.exe")
                    }
                }
                Button {
                    text: "0.0005"
                    onClicked: {
                        energy.isFast = false
                        controller.stopAxes(true)
                        controller.start("slow.exe")
                    }
                }
                }

                ChartView {
                    id: chartViewenergy
                    anchors.top: titlesub.bottom
                    anchors.bottom: parent.bottom
                    anchors.left: parent.horizontalCenter
                    anchors.leftMargin: -parent.width/4
                    anchors.right: parent.right
                    //animationOptions: ChartView.AllAnimations
                    ValueAxis {
                        id: valXenergy
                        min: controller.xmin
                        max: controller.xmax
                    }
                    ValueAxis {
                        id: valYenergy
                        min: controller.ymin
                        max: controller.ymax
                    }

                    LineSeries {
                        id: lineSeriesenergy
                        name: "fast"
                        axisX: valXenergy
                        axisY: valYenergy
                    }
                    LineSeries {
                        id: lineSeriesenergy2
                        name: "slow"
                        axisX: valXenergy
                        axisY: valYenergy
                    }
                    Timer {
                        id: refreshTimer
                        interval: 200
                        running: true
                        repeat: true
                        onTriggered: {
                            controller.update(chartViewenergy.series(energy.isFast?0:1));
                        }
                    }
                }
            }
        }
        Item {
            id: slide9
            property var start: 78
            anchors.fill: parent
            visible: root.current >= start
            Text {
                id: title9
                anchors.top: parent.top
                anchors.topMargin: 30*sc
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Demo + questions"
                font.pixelSize: 50*sc
                visible: root.current >= slide8.start
            }
            Button {
                anchors.centerIn: parent
                text: "Start"
                onClicked: {
                    controller.start("wk.exe", true)
                }
            }
        }
        Canvas {
            id:draw
            property int lx: 0
            property int ly: 0
            anchors.fill: parent
            function clear() {
                var ctx = getContext('2d')
                ctx.reset()
                requestPaint()
            }

            onPaint: {
                var ctx = getContext('2d')
                ctx.lineWidth = 5*sc
                ctx.beginPath()
                ctx.moveTo(lx,ly)
                lx=mouseHandler.mouseX
                ly=mouseHandler.mouseY
                ctx.lineTo(lx,ly)
                ctx.stroke()
            }
        }

        Keys.onPressed: {
            if(event.key == Qt.Key_Escape){
                root.visibility = Window.Windowed
                event.accepted = true
            }
            if(event.key == Qt.Key_F11){
                root.visibility = Window.FullScreen
                event.accepted = true
            }
            if(event.key == Qt.Key_C) {
                draw.clear()
                event.accepted = true
            }
            if(event.key == Qt.Key_D) {
                mouseHandler.drawEnable = !mouseHandler.drawEnable
                event.accepted = true
            }
            if(event.key == Qt.Key_Left) {
                root.current -= 1
            }
            if(event.key == Qt.Key_Right) {
                root.current += 1
            }
        }
    }
}
