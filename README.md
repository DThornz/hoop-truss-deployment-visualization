# Hoop Truss Deployable Mechanism Visualization

**Author:** Dr. Asad Mirza  
**Affiliation:** Assistant Research Professor, Biomedical Engineering,  
Florida International University  
**Last Updated:** July 28, 2025

---

This MATLAB script reproduces **Figure 28** from the paper:

> **Han, B., Xu, Y., Yao, J., Zheng, D., Guo, X., & Zhao, Y.**  
> *Configuration synthesis of hoop truss deployable mechanisms for space antenna based on screw theory*.  
> AIP Advances, 2019, 9(8), 085201.  
> [https://doi.org/10.1063/1.5115219](https://doi.org/10.1063/1.5115219)

---

## 📷 Demo

![Demo GIF](docs/demo.gif)

---

## Features

- Simulates the deployment of a circular hoop truss composed of 7R scissor-like units.
- Includes two visualization modes:
  - **Static Mode** – Displays folded, partially deployed, and fully deployed states.
  - **Animation Mode** – Visualizes the continuous deployment process.
- Models core structural components:
  - Upper/lower hoops
  - Vertical members
  - Scissor arms
  - Diagonal cross-bracing
  - Center joints

---

## Getting Started

### Requirements
- MATLAB R2020a or later
- No additional toolboxes required

### Usage

1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/hoop-truss-deployment-visualization.git
   cd hoop-truss-deployment-visualization
2. Open hoop_truss_visualization.m in MATLAB.
3. Select the mode.
    ```bash
    mode = "static";    % or "animation"
3. Run the script.

### 4. Contributions

Feel free to submit issues or pull requests for improvements or extensions.

### Citation

If you use or adapt this code, please cite the original publication and reference this repository.

Han, B., Xu, Y., Yao, J., Zheng, D., Guo, X., & Zhao, Y. (2019).
Configuration synthesis of hoop truss deployable mechanisms for space antenna based on screw theory.
AIP Advances, 9(8), 085201.
https://doi.org/10.1063/1.5115219
