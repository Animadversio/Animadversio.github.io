#\!/bin/bash

# Batch date conversion script for academic notes
convert_count=0

# Function to convert date and count
convert_date() {
    local file="$1"
    local old_pattern="$2"
    local new_pattern="$3"
    
    if grep -q "$old_pattern" "$file"; then
        sed -i '' "s/$old_pattern/$new_pattern/g" "$file"
        echo "Converted: $file"
        ((convert_count++))
    fi
}

# Convert all files with various date formats
echo "Starting batch date conversion..."

# January formats
convert_date "Note-on-Image-Prior.md" "date: Jan 14th, 2020" "date: 2020-01-14"
convert_date "Note on Data Visualization.md" "date: Jan. 20th, 2020" "date: 2020-01-20"
convert_date "Note on Krylov-Subspace Conjugate-Gradient-and-Lancosz-Iteration.md" "date: Jan 1st, 2020" "date: 2020-01-01"
convert_date "Note on Stochastic Lancosz Quadrature.md" "date: Jan 9th, 2020" "date: 2020-01-09"
convert_date "Note-on-Advanced-CV.md" "date: Jan 20th, 2020" "date: 2020-01-20"
convert_date "Note-on-Classic-CNN-Architecture.md" "date: Jan 17th, 2021" "date: 2021-01-17"
convert_date "Note-on-MRF-Image-Prior.md" "date: Jan 28th, 2020" "date: 2020-01-28"
convert_date "PCA-of-High-Dimensional-Trajectories.md" "date: Jan 22nd, 2022" "date: 2022-01-22"
convert_date "Note on Hessian Aware ZOO framework.md" "date: Jan. 21th, 2020" "date: 2020-01-21"
convert_date "Note-on-DDPM-DDIM-PNDM.md" "date: Jan. 16th, 2023" "date: 2023-01-16"

# February formats
convert_date "Epipolar-Geometry-and-Optic-Flow.md" "date: Feb 17th, 2020" "date: 2020-02-17"
convert_date "Stereo-Algorithms.md" "date: Feb 4th, 2020" "date: 2020-02-04"
convert_date "Note-on-Hardware-Computational-Photography.md" "date: Feb 27th, 2020" "date: 2020-02-27"
convert_date "Semantics-Vision-Task.md" "date: Feb 4th, 2020" "date: 2020-02-04"
convert_date "Spectrum-of-Tri-Toeplitz-matrix.md" "date: Feb 4th, 2022" "date: 2022-02-04"
convert_date "Note-on-Computational-Photography.md" "date: Feb 27th, 2020" "date: 2020-02-27"

# March formats
convert_date "Note-on-Kernel-PCA.md" "date: Mar 21st, 2022" "date: 2022-03-21"
convert_date "Note-on-GANs.md" "date: Mar 7th, 2020" "date: 2020-03-07"
convert_date "Note-on-Deep-RL.md" "date: Mar 18th, 2020" "date: 2020-03-20"
convert_date "Note-on-Photometric-Analysis.md" "date: Mar 17th, 2020" "date: 2020-03-17"

# April formats
convert_date "Note-on-Invariance-Stable-Manifold.md" "date: Apr 9th, 2021" "date: 2021-04-09"
convert_date "Note-on-Probabilistic-Model-of-Population.md" "date: Apr 16th, 2022" "date: 2022-04-16"
convert_date "Note-on-Matrix-Inversion-Determinant-Lemma.md" "date: Apr 16th, 2022" "date: 2022-04-16"
convert_date "Note-on-Nonlinear-System-Stability.md" "date: Apr 9th, 2021" "date: 2021-04-09"
convert_date "Note-on-Nonlinear-Dynamic-System.md" "date: Apr 9th, 2021" "date: 2021-04-09"
convert_date "Spectral-Graph-and-Segmentation.md" "date: Apr 22th, 2020" "date: 2020-04-22"

# May formats
convert_date "Note-on-Bifurcation-Normal-Form.md" "date: May 9th, 2021" "date: 2021-05-09"
convert_date "Note-on-MinMax-Game.md" "date: May 18th, 2020 (updated Oct.13th)" "date: 2020-05-18"
convert_date "Note-on-EM-and-lower-bound.md" "date: May 13th, 2022" "date: 2022-05-13"
convert_date "Brief-Note-on-Online-Computing-Correlation.md" "date: May 22th, 2020" "date: 2020-05-22"
convert_date "Note-on-Laplacian-Operator-Geometry.md" "date: May 8th, 2020" "date: 2020-05-08"
convert_date "Note-on-Feedback-Stablization.md" "date: May 10th, 2021" "date: 2021-05-10"
convert_date "Note-on-Diffusion-Generative-Model.md" "date: May 9th, 2022" "date: 2022-05-09"
convert_date "Note-on-Belief-Propagation-Algorithm.md" "date: May 18th, 2019" "date: 2019-05-18"

# June formats
convert_date "Notes-on-Algorithms-for-Non-Negative-Matrix-Factorization.md" "date: June 25th, 2019 (updated May 22, 2020)" "date: 2019-06-25"
convert_date "Note-on-Equiv-Score-Matching-Objective.md" "date: June 20th, 2022" "date: 2022-06-20"
convert_date "Note on Selective Attention.md" "date: June 24th, 2019" "date: 2019-06-24"

# July formats
convert_date "Note-on-Gaussian-Process.md" "date: July 1st, 2020" "date: 2020-07-01"
convert_date "Note on Network Commnunication.md" "date: July 30th, 2019" "date: 2019-07-30"
convert_date "Note-on-Hippo.md" "date: July  25th, 2022" "date: 2022-07-25"
convert_date "This Week's Learning about Brain 4 Neural Correlate of Visual Consciousness.md" "date: July 2nd, 2019" "date: 2019-07-02"
convert_date "Note-on-S4-model.md" "date: July  17th, 2022" "date: 2022-07-17"
convert_date "Note-on-Variational-Inference.md" "date: July 27th, 2020" "date: 2020-07-27"
convert_date "Note-on-Bayesian-Optimization.md" "date: July 1st, 2020" "date: 2020-07-01"

# August formats
convert_date "Note on Behavioral Study.md" "date: Aug 28th, 2019" "date: 2019-08-28"
convert_date "Note-on-Neural-Tuning-and-Information.md" "date: Aug. 24th, 2020" "date: 2020-08-24"

# September formats
convert_date "Note on Optimization on Manifold.md" "date: Sept. 29th, 2019" "date: 2019-09-29"
convert_date "Note-on-Deep-Unsupervised-Learning.md" "date: September 13th, 2019" "date: 2019-09-13"
convert_date "Note-on-Feature-Visualization.md" "date: September 17th, 2019" "date: 2019-09-17"
convert_date "Note on Fragment Based Object Recognition.md" "date: Sept 25th, 2019" "date: 2019-09-25"
convert_date "Note on Animal Perception.md" "date: Sept 12th, 2019" "date: 2019-09-12"
convert_date "Note-on-Computer-Vision.md" "date: September 10th, 2019" "date: 2019-09-10"

# October formats
convert_date "Note on Categorization and Concepts.md" "date: Oct 24th, 2019" "date: 2019-10-24"
convert_date "Some Statistical Computation on Sphere.md" "date: Oct 13th, 2019 (updated Dec.1st 2020)" "date: 2019-10-13"
convert_date "Note on CNN Interpretability.md" "date: Oct 4th, 2019" "date: 2019-10-04"
convert_date "Note-on-Non-parametric-regression.md" "date: Oct 13th, 2020 (Updated Dec 17th, 2021)" "date: 2020-10-13"

# November formats
convert_date "Note-on-Hopfield-Network.md" "date: Nov 15th, 2021" "date: 2021-11-15"
convert_date "Note-on-Word-Embedding.md" "date: Nov 27th, 2020" "date: 2020-11-27"
convert_date "Note-on-ShapeCollage.md" "date: Nov. 2nd, 2019" "date: 2019-11-02"
convert_date "Note on Visual Imagery.md" "date: Nov. 5th, 2019" "date: 2019-11-05"
convert_date "Note-on-Modern-Hopfield-Net-Transformer.md" "date: Nov 15th, 2021" "date: 2021-11-15"
convert_date "Note-on-Local-Feature-Descriptors.md" "date: Nov. 4th, 2019" "date: 2019-11-04"
convert_date "Note-on-LBFGS.md" "date: Nov 11th, 2019" "date: 2019-11-11"

# December formats
convert_date "Note-on-Kernel-Ridge-Regression.md" "date: Dec 17th, 2021" "date: 2021-12-17"
convert_date "Comparison-of-Major-DL-Frameworks.md" "date: Dec 18th, 2019" "date: 2019-12-18"
convert_date "Note-on-Online-Update-Regression-Algorithms.md" "date: Dec 15th, 2019" "date: 2019-12-15"

echo "Conversion complete\! Total files converted: $convert_count"
