import QtQuick
import JASP.Module

Description
{
    title:       qsTr("Variability Chart")
    description: qsTr("Generates variability charts using the VCA package.")
    version:     "0.1.0"
    author:      "Developer <samuelbaco@gmail.com>"
    maintainer:  "Developer <samuelbaco@gmail.com>"
    website:     "https://github.com/jasp-stats/jaspVariability"
    license:     "GPL (>= 2)"
    icon:        "varPlot.svg"
    preloadData: true

    Analysis
    {
        title: qsTr("Variability Plot")
        qml:   "VarPlot.qml"
        func:  "VarPlot"
        info:  qsTr("Creates variability plots to visualize variance components across hierarchical factors.")
    }
}