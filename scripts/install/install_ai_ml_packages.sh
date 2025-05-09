#!/bin/bash

# Define colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check if Python is installed
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}Python 3 is not installed. Please install Python first.${NC}"
    exit 1
fi

# Check if pip is installed
if ! command -v pip3 &> /dev/null; then
    echo -e "${RED}pip3 is not installed. Please install pip first.${NC}"
    exit 1
fi

# Upgrade pip
echo -e "${BLUE}Upgrading pip...${NC}"
pip3 install --upgrade pip

# Install core scientific computing packages
echo -e "${BLUE}Installing core scientific computing packages...${NC}"
pip3 install numpy scipy pandas matplotlib seaborn

# Install machine learning packages
echo -e "${BLUE}Installing machine learning packages...${NC}"
pip3 install scikit-learn tensorflow keras

# Install deep learning packages
echo -e "${BLUE}Installing deep learning packages...${NC}"
pip3 install torch torchvision torchaudio

# Install natural language processing packages
echo -e "${BLUE}Installing NLP packages...${NC}"
pip3 install nltk spacy transformers

# Install data processing and visualization packages
echo -e "${BLUE}Installing data processing and visualization packages...${NC}"
pip3 install plotly bokeh dash

# Install additional useful packages
echo -e "${BLUE}Installing additional useful packages...${NC}"
pip3 install jupyter ipywidgets tqdm requests beautifulsoup4

# Download spaCy language model
echo -e "${BLUE}Downloading spaCy language model...${NC}"
python3 -m spacy download en_core_web_sm

# Download NLTK data
echo -e "${BLUE}Downloading NLTK data...${NC}"
python3 -c "import nltk; nltk.download('punkt'); nltk.download('stopwords'); nltk.download('wordnet')"

echo -e "${GREEN}✅ AI/ML packages installation completed!${NC}"
echo -e "${BLUE}You can now use these packages in your Python environment.${NC}" 