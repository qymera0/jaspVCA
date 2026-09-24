import QtQuick
import JASP
import JASP.Controls

Form
{
    VariablesForm
    {
        AvailableVariablesList { name: "allVariablesList" }
        AssignedVariablesList
        {
            name: "dependent"
            title: qsTr("Dependent Variable")
            singleVariable: true
            allowedColumns: ["scale"]
            info: qsTr("The continuous response variable to be analyzed.")
        }
        AssignedVariablesList
        {
            name: "randomFactors"
            title: qsTr("Factors (Hierarchical Order)")
            allowedColumns: ["nominal", "ordinal"]
            info: qsTr("Categorical factors defining the variance components, ordered from highest to lowest hierarchy.")
        }
    }

    Section
    {
        title: qsTr("Plot Options")

        DropDown
        {
            name: "type"
            label: qsTr("Plot Type")
            values: [
                { label: qsTr("Scatterplot"), value: "1" },
                { label: qsTr("SD/CV Plot"), value: "2" },
                { label: qsTr("Both"), value: "3" }
            ]
            info: qsTr("Select the type of variability chart to display.")
        }

        DropDown
        {
            name: "varType"
            label: qsTr("Variance Measure (for Type 2/3)")
            values: [
                { label: qsTr("Standard Deviation (SD)"), value: "SD" },
                { label: qsTr("Coefficient of Variation (CV)"), value: "CV" }
            ]
            info: qsTr("Measure of variability to plot when Type 2 or 3 is selected.")
        }

        CheckBox 
        { 
            name: "keepOrder"
            label: qsTr("Keep factor ordering from data")
            checked: true
            info: qsTr("Preserves the original data ordering of factor levels in the plot.") 
        }
        
        CheckBox 
        { 
            name: "boxplot"
            label: qsTr("Add Boxplot to lowest level")
            checked: false
            info: qsTr("Overlays a boxplot on the lowest hierarchical factor level.") 
        }
        
        CheckBox 
        { 
            name: "meanLine"
            label: qsTr("Add Overall Mean Line")
            checked: false
            info: qsTr("Draws a horizontal line indicating the overall mean across all data.") 
        }

        IntegerField
        {
            name: "maxLevel"
            label: qsTr("Max Factor Levels for Vertical Lines")
            defaultValue: 25
            min: 1
            info: qsTr("Maximum number of factor levels before vertical separation lines are suppressed to prevent visual clutter.")
        }
    }
}