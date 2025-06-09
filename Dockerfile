# Stage 1: Use the official Python image as a base
FROM python:3.12-slim

# Stage 2: Set the working directory in the container
WORKDIR /app

# Stage 3: Copy the requirements file into the container
COPY requirements.txt .

# Stage 4: Install the Python dependencies
# Using --no-cache-dir to reduce image size
RUN pip install --no-cache-dir -r requirements.txt

# Stage 5: Copy the application code into the container
COPY . .

# Stage 6: Expose the port that Streamlit runs on
EXPOSE 8501

# Stage 7: Define the command to run the application
# Use healthcheck to ensure Streamlit is responsive
HEALTHCHECK --interval=15s --timeout=5s \
  CMD curl -f http://localhost:8501/_stcore/health

CMD [ "streamlit", "run", "app.py" ]
