# Use an Ubuntu base image
FROM ubuntu:22.04

# Install dependencies, including Python and Node.js
RUN apt-get update && \
    apt-get install -y curl python3 python3-pip && \
    curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Check versions to confirm installation
RUN node --version && npm --version && python3 --version && pip3 --version


# Check if Python and pip were installed correctly
RUN python3 --version && pip3 --version
WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

EXPOSE 8080

#CMD ["uvicorn", "main:app", "--reload", "--host", "0.0.0.0", "--port", "8080"]



#FROM node:18-alpine

WORKDIR /app


# Install pnpm globally at the specified version (replace with your version)
RUN npm install -g pnpm@9.0.0

# Copy package.json and pnpm-lock.yaml for dependency installation
COPY package.json pnpm-lock.yaml ./

# Install dependencies using pnpm
RUN pnpm install

COPY . .

EXPOSE 3000

CMD ["npm", "run", "dev"]