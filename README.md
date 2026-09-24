# jaspVCA: Variability Chart Module for JASP

This module extends JASP by integrating the Variability Chart (`varPlot`) functionality from the R `VCA` package, allowing users to visualize variance components in hierarchical and cross-classified data directly within the JASP interface[cite: 4, 10]. 

## Features
* **Dependent Variable:** Select your continuous scale measurement.
* **Random Factors:** Assign categorical grouping variables to define the hierarchical structure.
* **Customization:** Adjust plot type, variance representation (SD/CV), mean lines, and boxplot overlays.

## Installation

### Option 1: JASP Module Library (Recommended)
Once this module is approved and merged into the community registry, install it directly inside JASP:
1. Open JASP (ensure you are using a recent nightly or beta build)[cite: 10].
2. Click the **+** icon in the top-right corner of the main JASP window.
3. Locate the module under the Community Modules list and click to install it.

### Option 2: Manual Installation (Developer Mode)
To use the current local development version natively on Windows:
1. Download or clone this repository to your machine.
2. Open JASP and navigate to **Menu (☰) -> Preferences -> Advanced**[cite: 4].
3. Check **Developer mode**[cite: 4].
4. Return to the main JASP window, click the **+** icon (top-right), and select **Install Developer Module**[cite: 4].
5. Browse to the downloaded `jaspVCA` folder and select it to load the module into your top ribbon.

## Usage
1. Open JASP and load your dataset (e.g., via **Menu (☰) -> Open -> Computer -> Browse**).
2. Click the **Variability Plot** module icon in the top ribbon.
3. Drag your continuous measurement variable into the **Dependent Variable** field.
4. Drag your categorical grouping variables into the **Factors** field in their hierarchical order.
5. The Variability Chart will automatically render in the results panel on the right.

![Variability Plot Example](inst/help/img/screenshot.png) 
*(Note: Replace `inst/help/img/screenshot.png` with the actual path to your module screenshot to satisfy the community checklist)*[cite: 10]

## Contributing and Issues
If you encounter any bugs or have feature requests, please open an issue on the GitHub repository. To contribute code or fixes, follow the fork-based workflow and submit a cross-fork pull request to the module registry[cite: 4].
