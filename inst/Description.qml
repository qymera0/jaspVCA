import QtQuick
import JASP.Module

Description
{
    title:       qsTr("Variability Chart")
    description: qsTr("Generates variability charts using the VCA package.")
    version:     "0.2.0"
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
    }
}
