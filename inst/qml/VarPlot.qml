import QtQuick
import JASP.Controls

Form
{
    VariablesForm
    {
        AvailableVariablesList { name: "variables" }
        AssignedVariablesList
        {
            name:           "dependent"
            title:          qsTr("Dependent Variable")
            singleVariable: true
            allowedColumns: ["scale"]
        }
        AssignedVariablesList
        {
            name:           "randomFactors"
            title:          qsTr("Factors (Nesting Order)")
            allowedColumns: ["nominal", "ordinal"]
        }
    }

    Section
    {
        title: qsTr("Graph Configuration")

        CheckBox
        {
            name:    "keepOrder"
            label:   qsTr("Keep original factor level order")
            checked: true
        }

        DropDown
        {
            name:   "type"
            label:  qsTr("Plot type")
            values: ["1", "2", "3"]
        }

        RadioButtonGroup
        {
            name:    "varType"
            title:   qsTr("Variability metric")
            enabled: options.type !== "1"
            RadioButton { value: "SD"; label: qsTr("Standard deviation (SD)") }
            RadioButton { value: "CV"; label: qsTr("Coefficient of variation (CV)") }
        }
    }

    Section
    {
        title: qsTr("Summarization")

        CheckBox
        {
            name:    "showMeanPoints"
            label:   qsTr("Display factor level mean points")
            checked: true
        }

        CheckBox
        {
            name:    "showMeanLine"
            label:   qsTr("Display factor level mean lines")
            checked: true

            Group
            {
                enabled: options.showMeanLine

                CheckBox
                {
                    name:    "meanLineGrand"
                    label:   qsTr("Overall mean (Grand mean / Intercept)")
                    checked: true
                }
                CheckBox
                {
                    name:    "meanLineFactors"
                    label:   qsTr("Factor level means")
                    checked: true
                }
            }
        }
    }

    Section
    {
        title: qsTr("Labels")

        TextField
        {
            name:  "titleText"
            label: qsTr("Main title")
        }

        TextField
        {
            name:  "yAxisLabel"
            label: qsTr("Y-axis label")
        }

        TextField
        {
            name:    "sdYAxisLabel"
            label:   qsTr("SD/CV Y-axis label")
            enabled: options.type !== "1"
        }

        CheckBox
        {
            name:    "showVCnam"
            label:   qsTr("Display variance component names")
            checked: true
        }

        CheckBox
        {
            name:    "useVarNam"
            label:   qsTr("Prepend factor variable names to level specifiers")
            checked: false
        }
    }

    Section
    {
        title: qsTr("Appearance & Visuals")

        DropDown
        {
            name:   "colorPalette"
            label:  qsTr("Color palette")
            values: ["whirlpool", "jasp", "viridis"]
        }

        CheckBox
        {
            name:    "showBG"
            label:   qsTr("Alternate background coloring for top-level factor")
            checked: false
        }

        CheckBox
        {
            name:    "customYLim"
            label:   qsTr("Custom Y-axis limits")
            checked: false

            Group
            {
                enabled: options.customYLim
                DoubleField { name: "yMin"; label: qsTr("Minimum Y"); defaultValue: 0 }
                DoubleField { name: "yMax"; label: qsTr("Maximum Y"); defaultValue: 100 }
            }
        }
    }

    Section
    {
        title: qsTr("Reference Lines")

        CheckBox
        {
            name:    "showVLine"
            label:   qsTr("Vertical factor level boundary lines")
            checked: true

            Group
            {
                enabled: options.showVLine
                CheckBox
                {
                    name:    "vLineTable"
                    label:   qsTr("Extend vertical lines into design table")
                    checked: true
                }
            }
        }

        CheckBox
        {
            name:    "showHLine"
            label:   qsTr("Horizontal reference lines")
            checked: false
        }
    }

    Section
    {
        title: qsTr("Other Options")

        DoubleField
        {
            name:         "htab"
            label:        qsTr("Design table vertical proportion (htab)")
            defaultValue: 0.2
            min:          0.05
            max:          0.8
        }

        CheckBox
        {
            name:    "showJoin"
            label:   qsTr("Connect observed points within lowest factor level")
            checked: true
        }

        CheckBox
        {
            name:    "showBoxplot"
            label:   qsTr("Overlay subgroup boxplots")
            checked: false
        }

        IntegerField
        {
            name:         "maxLevel"
            label:        qsTr("Maximum factor levels allowed for vertical lines")
            defaultValue: 25
            min:          2
            max:          500
        }
    }
}