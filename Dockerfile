# Base Python image
FROM python:3.10-slim

# Set work directory
WORKDIR /app

# Install system dependencies (for fonts, reportlab, etc.)
RUN apt-get update && apt-get install -y \
    build-essential \
    libfreetype6-dev \
    libxft-dev \
    libxrender1 \
    libfontconfig1 \
    && rm -rf /var/lib/apt/lists/*

# Copy requirements first (for caching)
COPY General/requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy app files
COPY General/ /app/

# Expose Streamlit default port
EXPOSE 8501

# Set environment variables for Streamlit
ENV STREAMLIT_SERVER_HEADLESS true
ENV STREAMLIT_SERVER_PORT 8501
ENV STREAMLIT_SERVER_ENABLECORS false

# Command to run the app
CMD ["streamlit", "run", "Generalize.py"]
