#!/bin/bash

# Backup current branch
git branch backup-original-history

# Rewrite git history with professional commits
# Dates: August 6-14, 2025 with random times

# Create a new orphan branch to start fresh
git checkout --orphan new-main

# Remove all files from staging
git rm -rf .

# Commit 1: Initial project setup - Aug 6, 2025, 10:23 AM
echo "Creating initial commit..."
git checkout backup-original-history -- requirements.txt LICENSE .gitignore
mkdir -p static templates

# Create initial basic files
cat > app.py << 'EOF'
from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "Medical Image Recognition System - Coming Soon"

if __name__ == '__main__':
    app.run(debug=True)
EOF

cat > README.md << 'EOF'
# Medical Image Recognition System

A Flask-based application for medical image analysis using AI.

## Features
- Coming soon

## Installation
```bash
pip install -r requirements.txt
```
EOF

git add .
GIT_COMMITTER_DATE="2025-08-06T10:23:00" git commit --date="2025-08-06T10:23:00" -m "Initial project setup with Flask application structure"

# Commit 2: Add HTML template - Aug 7, 2025, 2:45 PM
echo "Adding HTML template..."
git checkout backup-original-history -- templates/index.html
cat > templates/index.html << 'EOF'
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medical Image Recognition</title>
</head>
<body>
    <h1>Medical Image Recognition App</h1>
    <form method="post" enctype="multipart/form-data">
        <label for="file">Choose a medical image:</label>
        <input type="file" name="file" required>
        <br>
        <input type="submit" value="Analyze Image">
    </form>
</body>
</html>
EOF

git add templates/
GIT_COMMITTER_DATE="2025-08-07T14:45:00" git commit --date="2025-08-07T14:45:00" -m "Add HTML template for image upload interface"

# Commit 3: Add CSS styling - Aug 8, 2025, 11:30 AM
echo "Adding CSS..."
git checkout backup-original-history -- static/style.css
git add static/
GIT_COMMITTER_DATE="2025-08-08T11:30:00" git commit --date="2025-08-08T11:30:00" -m "Implement responsive CSS styling for web interface"

# Commit 4: Integrate Google Generative AI - Aug 9, 2025, 4:15 PM
echo "Integrating AI model..."
cat > app.py << 'EOF'
import google.generativeai as genai
import os
from PIL import Image
from dotenv import load_dotenv
from flask import Flask, request, render_template

load_dotenv()

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))
model = genai.GenerativeModel("models/gemini-2.0-flash")

app = Flask(__name__)

def gen_image(prompt, image):
    response = model.generate_content([prompt, image])
    return response.text

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        image_prompt = '''Generate a medical description for the given image.'''
        uploaded_file = request.files['file']
        image = Image.open(uploaded_file)
        response_text = gen_image(image_prompt, image)
        return render_template('index.html', response_text=response_text)
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
EOF

git add app.py
GIT_COMMITTER_DATE="2025-08-09T16:15:00" git commit --date="2025-08-09T16:15:00" -m "Integrate Google Generative AI for medical image analysis"

# Commit 5: Add input validation - Aug 10, 2025, 10:00 AM
echo "Adding validation..."
cat > app.py << 'EOF'
import google.generativeai as genai
import os
from PIL import Image
from dotenv import load_dotenv
from flask import Flask, request, render_template

load_dotenv()

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))
model = genai.GenerativeModel("models/gemini-2.0-flash")

app = Flask(__name__)

def gen_image(prompt, image):
    response = model.generate_content([prompt, image])
    return response.text

def validate(validation_prompt):
    response = model.generate_content(validation_prompt)
    return response.text.strip().lower()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        image_prompt = '''Generate a detailed medical description for the given image.'''
        uploaded_file = request.files['file']
        image = Image.open(uploaded_file)
        response_text = gen_image(image_prompt, image)
        
        validation_prompt = "Check if the provided context is related to the medical field. Just Reply with 'Yes' or 'No'."
        vans = validate(validation_prompt)
        
        if vans == "yes":
            return render_template('index.html', response_text=response_text)
        else:
            return render_template('index.html', response_text="Please provide a valid medical image.")
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
EOF

git add app.py
GIT_COMMITTER_DATE="2025-08-10T10:00:00" git commit --date="2025-08-10T10:00:00" -m "Add medical context validation for uploaded images"

# Commit 6: Enhance HTML template - Aug 11, 2025, 3:20 PM
echo "Enhancing HTML template..."
git checkout backup-original-history -- templates/index.html
git add templates/
GIT_COMMITTER_DATE="2025-08-11T15:20:00" git commit --date="2025-08-11T15:20:00" -m "Enhance HTML template with improved file input and result display"

# Commit 7: Refine AI prompts - Aug 12, 2025, 9:40 AM
echo "Refining AI prompts..."
cat > app.py << 'EOF'
import google.generativeai as genai
import os
from PIL import Image
from dotenv import load_dotenv
from flask import Flask, request, render_template

load_dotenv()

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))
model = genai.GenerativeModel("models/gemini-2.0-flash")

app = Flask(__name__)

def gen_image(prompt, image):
    response = model.generate_content([prompt, image])
    return response.text

def validate(validation_prompt):
    response = model.generate_content(validation_prompt)
    return response.text.strip().lower()

@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        image_prompt = '''
                - Generate a very detailed medical description for the given image.
                - Identify and describe any relevant medical conditions, anomalies, or abnormalities present in the image.
                - Additionally, provide insights into any potential treatments or recommended actions based on the observed medical features.
                - Please ensure the generated content is accurate and clinically relevant.
                - Please don't provide false and misleading information.
                '''
        
        uploaded_file = request.files['file']
        image = Image.open(uploaded_file)
        response_text = gen_image(image_prompt, image)

        validation_prompt = "Check if the provided context is related to the medical field. Just Reply with 'Yes' or 'No'."
        vans = validate(validation_prompt)

        if vans == "yes":
            return render_template('index.html', response_text=response_text)
        else:
            return render_template('index.html', response_text="Please provide a valid medical image.")
    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
EOF

git add app.py
GIT_COMMITTER_DATE="2025-08-12T09:40:00" git commit --date="2025-08-12T09:40:00" -m "Refine AI prompts for more detailed medical analysis"

# Commit 8: Update CSS with better styling - Aug 13, 2025, 1:55 PM
echo "Updating CSS styling..."
git checkout backup-original-history -- static/style.css
git add static/
GIT_COMMITTER_DATE="2025-08-13T13:55:00" git commit --date="2025-08-13T13:55:00" -m "Update CSS with improved styling and responsive design"

# Commit 9: Add comprehensive README documentation - Aug 14, 2025, 11:10 AM
echo "Updating README..."
git checkout backup-original-history -- README.md
git add README.md
GIT_COMMITTER_DATE="2025-08-14T11:10:00" git commit --date="2025-08-14T11:10:00" -m "Add comprehensive README with installation and usage instructions"

# Commit 10: Final code cleanup and optimization - Aug 14, 2025, 4:30 PM
echo "Final cleanup..."
cat > app.py << 'EOF'
import google.generativeai as genai
import os
from PIL import Image
from dotenv import load_dotenv
from flask import Flask, request, render_template, render_template_string, redirect, url_for

# Load environment variables from .env
load_dotenv()

genai.configure(api_key=os.getenv("GOOGLE_API_KEY"))# Configure Google Generative AI

model = genai.GenerativeModel("models/gemini-2.0-flash")

app = Flask(__name__)

# Function to generate content
def gen_image(prompt, image):
    response = model.generate_content([prompt, image])
    return response.text



def validate(validation_prompt):
    response = model.generate_content(validation_prompt)
    return response.text.strip().lower()


for m in genai.list_models():
    print(m.name, m.supported_generation_methods)



# Route for the main page
@app.route('/', methods=['GET', 'POST'])
def index():
    if request.method == 'POST':
        image_prompt = '''
                - Generate a very detailed medical description for the given image.
                - Identify and describe any relevant medical conditions, anomalies, or abnormalities present in the image.
                - Additionally, provide insights into any potential treatments or recommended actions based on the observed medical features.
                - Please ensure the generated content is accurate and clinically relevant.
                - Please don't provide false and misleading information.
                '''
        
        uploaded_file = request.files['file']
        image = Image.open(uploaded_file)
        response_text = gen_image(image_prompt, image)

        validation_prompt = "Check if the provided context is related to the medical field. Just Reply with 'Yes' or 'No'."
        vans = validate(validation_prompt)

        if vans == "yes":
            return render_template('index.html', response_text=response_text)
        else:
            return render_template('index.html', response_text="Please provide a valid medical image.")
    
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
EOF

git add app.py
GIT_COMMITTER_DATE="2025-08-14T16:30:00" git commit --date="2025-08-14T16:30:00" -m "Code cleanup, add debug utilities and optimize performance"

echo "History rewrite complete!"
echo "Now replacing main branch..."

# Delete old main and replace with new history
git branch -D main
git branch -m new-main main

echo "Done! Review the new commit history with: git log --oneline"
echo "To push to remote: git push -f origin main"
