# Use AWS Lambda Python 3.13 base image
FROM public.ecr.aws/lambda/python:3.13-arm64

# Set environment variables
ENV PYTHONUNBUFFERED=1 \
    DEBIAN_FRONTEND=noninteractive \
    PLAYWRIGHT_BROWSERS_PATH=/opt/playwright \
    PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1 \
    PLAYWRIGHT_CHROMIUM_EXECUTABLE_PATH=/opt/playwright/chromium-*/chrome


# Install system dependencies for Chromium only
RUN microdnf install -y \
    --setopt=tsflags=nodocs \
    --setopt=keepcache=1 \
    # Core system libraries
    nss \
    nss-util \
    nspr \
    # Accessibility and input
    atk \
    at-spi2-atk \
    # X11 and graphics libraries (minimal set for headless)
    libX11 \
    libXcomposite \
    libXdamage \
    libXext \
    libXfixes \
    libXrandr \
    libxcb \
    libxkbcommon \
    # Graphics and rendering
    mesa-libgbm \
    libgbm \
    # Audio and printing (required by Chromium)
    alsa-lib \
    cups-libs \
    # Additional dependencies for browser stability
    pango \
    dbus \
    cairo \
    # Pytest \
    python3-devel \
    # Git
    git \
    && microdnf clean all \
    && rm -rf /var/cache/microdnf

# Install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt && \
    rm -rf /root/.cache/pip

# Install Playwright browsers and set proper permissions
RUN playwright install chromium && \
    chmod -R 777 /opt/playwright && \
    find /opt/playwright -type f -name "chrome" -exec chmod +x {} \; && \
    # Create necessary directories
    mkdir -p /tmp/.com.google.Chrome && \
    chmod -R 777 /tmp/.com.google.Chrome

# Set working directory
WORKDIR ${LAMBDA_TASK_ROOT}

# Remove the specific Lambda function and CMD
# Users of this base image should provide their own handler