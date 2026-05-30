FROM python:3.9-slim

# Install system dependencies with minimal footprint
RUN apt-get update && apt-get install -y \
    chromium \
    chromium-driver \
    libnss3 libxss1 libasound2 libatk-bridge2.0-0 libgtk-3-0 libgbm-dev \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY . .

# Memory Optimization Flags for Chromium
ENV CHROME_ARGS="--no-sandbox --disable-dev-shm-usage --disable-gpu --disable-software-rasterizer --single-process"

CMD ["python3", "bot.py"]
