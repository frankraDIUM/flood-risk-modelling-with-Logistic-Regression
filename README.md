

---

# Flood Risk Modelling for Greater Accra Region using Logistic Regression

## 📖 Project Overview

This project employs **Geographic Information Systems (GIS)** and **Logistic Regression (LR)** to model and predict flood risk in the Greater Accra Region of Ghana. The model integrates multiple environmental variables—such as elevation, slope, rainfall, land use, and proximity to water bodies—to create a high-resolution flood risk map. The primary goal is to identify areas most susceptible to flooding to aid in urban planning, disaster preparedness, and the development of sustainable mitigation strategies.

The logistic regression model achieved an impressive **98.2% accuracy** with an **AUC of 0.975**, demonstrating its high predictive capability.

## 🗺️ Study Area

The study focuses on the **Greater Accra Region**, Ghana's smallest but most densely populated region, which includes the national capital, Accra. Its low-lying coastal plains, rapid urbanization, and inadequate drainage infrastructure make it highly vulnerable to frequent and severe flooding.

*   **Location:** 5°30'N - 6°30'N, 0°10'W - 0°30'E
*   **Total Area:** 3,245 km² (1.4% of Ghana's land area)

## 📊 Data Sources and Processing

All spatial data were projected in the **WGS1984** coordinate system. The following datasets were collected and processed in **ArcGIS Pro**:

| Variable Category | Data Description | Source |
| :--- | :--- | :--- |
| **Response Variable** | Historical Flood Areas (Polygons, 2011-2020) | [UNU-INWEH World Flood Mapping Tool](https://floodmapping.inweh.unu.edu/) |
| **Topographic** | Digital Elevation Model (DEM) | USGS Landsat 8 Imagery |
| | Slope & Elevation | Derived from DEM in ArcGIS Pro |
| **Hydrological** | Drainage Density | Derived from DEM using Hydrology Tool |
| | Rainfall (2011-2020) | Climatic Research Unit (CRU) |
| **Land Cover** | Land Use/Land Cover (LULC) | Classified from Landsat imagery (5 classes: Water, Vegetation, Shrubland, Settlement, Bare Land) |
| **Proximity** | Distance to Rivers, Lakes, Drains, Roads | BBBike Extract Service |
| | | Euclidean Distance calculated in ArcGIS Pro |

## ⚙️ Methodology

### 1. Data Preparation in GIS
- Historical flood polygons were converted to point features using the **Extract-to-Points** tool.
- Values from all environmental variable rasters were extracted to these flood points using the **Extract Multi Values to Points** tool.
- The resulting attribute table was exported for statistical analysis.

### 2. Statistical Modelling
- Data cleaning was performed using **Python**.
- **Logistic Regression** was implemented using **R**.
- The dataset was split into **80% training** and **20% testing** sets.
- A correlation analysis was first conducted to understand variable relationships.
- The model was trained, and its performance was evaluated using:
    - Accuracy, AUC-ROC Curve
    - Confusion Matrix
    - Mean Squared Error (MSE) and Root Mean Squared Error (RMSE)

### 3. Flood Risk Map Generation
The derived coefficients from the logistic regression model were applied back in **ArcGIS Pro** using the **Raster Calculator** with the following formula:

**Flood Risk Probability = Exp(Σ(Coefficient_i * Variable_i) + Intercept) / (1 + Exp(Σ(Coefficient_i * Variable_i) + Intercept))**

The resulting probability raster was classified into five distinct flood risk zones:
1.  **Very Low**
2.  **Low**
3.  **Moderate**
4.  **High**
5.  **Very High**

## 📈 Results and Validation

### Key Findings from the Logistic Regression Model:
- **Accuracy:** 98.2%
- **AUC:** 0.975
- **MSE:** 0.0132
- **RMSE:** 0.1147

### Variable Coefficients and Significance:
The table below shows the contribution (coefficient) and statistical significance (p-value) of each predictor variable. A negative coefficient indicates that an increase in the variable decreases the log-odds of a flood occurring.

| Variable | Coefficient | p-value | Interpretation |
| :--- | :--- | :--- | :--- |
| **Intercept** | -20.3611 | < 0.001 | - |
| **Land Use (LULC)** | +1.9425 | < 0.001 | Strong positive impact on flood risk. |
| **Elevation** | +3.2334 | < 0.001 | Counter-intuitive result; requires domain context. |
| **Distance to Rivers** | -0.4182 | < 0.001 | Increased distance reduces flood risk. |
| **Rainfall** | -0.5261 | < 0.001 | Counter-intuitive result; requires investigation. |
| **Distance to Roads** | -0.2469 | < 0.001 | Increased distance reduces flood risk. |
| **Drainage Density** | +0.2568 | < 0.001 | Higher density increases flood risk. |
| **Distance to Drains** | +0.2374 | < 0.001 | Closer proximity to drains increases risk (may indicate floodwater collection). |
| **Distance to Lakes** | +0.1829 | < 0.001 | Closer proximity to lakes increases risk. |
| **Slope** | -0.8932 | 0.0832 | Steeper slopes reduce flood risk (less significant). |

### Final Output:
The project's primary output is a **Flood Risk Zonation Map** of the Greater Accra Region, visually identifying hotspots and safe zones for planners and policymakers.
![Flood Risk Map]((https://github.com/frankraDIUM/flood-risk-modelling-with-Logistic-Regression/blob/main/Flood%20Risk%20Map.jpg))



## 🛠️ Installation and Usage

### Prerequisites
- **GIS Software:** ArcGIS Pro (with Spatial Analyst license)
- **Statistical Software:** R (with `caret`, `pROC`, `corrplot` packages) and/or Python (with `pandas`, `numpy`, `sklearn`)

### Steps to Reproduce:
1.  **Clone the repository:** `git clone [repository-url]`
2.  **Open the ArcGIS Pro Project** (`GIS/ArcGIS_Pro_Project.aprx`) to explore data layers and processing steps.
3.  **Run the Python script** (`Scripts/01_Data_Cleaning.py`) to clean the extracted data.
4.  **Run the R script** (`Scripts/02_Logistic_Regression.R`) to build, validate the model, and extract coefficients.
5.  **Apply the coefficients** in ArcGIS Pro's Raster Calculator using the provided formula to generate the final risk map.

## 🎯 Conclusions and Impact

This study successfully demonstrates the power of combining GIS with statistical modelling for environmental risk assessment. The high accuracy of the model confirms that the selected variables are strong predictors of flooding in Greater Accra.

- **Urban Planning:** The flood risk map is a critical tool for guiding future development away from high-risk zones.
- **Disaster Management:** enables efficient resource allocation for early warning systems and emergency response.
- **Sustainable Development:** Contributes directly to achieving UN Sustainable Development Goals (SDGs) 11 (Sustainable Cities) and 13 (Climate Action).

## 🔮 Future Work

- Incorporate climate change projections to model future flood risk scenarios.
- Integrate real-time sensor data for dynamic flood forecasting.
- Include more socioeconomic variables (e.g., population density, poverty index) to assess vulnerability.
- Compare the Logistic Regression model with machine learning models like Random Forest or XGBoost.



## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- United Nations University Institute for Water, Environment and Health (UNU-INWEH)
- US Geological Survey (USGS)
- Ghana Meteorological Agency (GMET)
- BBBike.org

---
