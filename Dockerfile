FROM python:3.10-slim

WORKDIR /app

# Install system dependencies for fonts and reportlab
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libxft-dev \
    libxrender1 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (cache layer)
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy all project files (Generalize.py, fonts, etc.)
COPY . /app/

EXPOSE 8501

# Streamlit configs
ENV STREAMLIT_SERVER_HEADLESS true
ENV STREAMLIT_SERVER_PORT 8501
ENV STREAMLIT_SERVER_ENABLECORS false

# Run Streamlit app
CMD ["streamlit", "run", "Generalize.py"]
