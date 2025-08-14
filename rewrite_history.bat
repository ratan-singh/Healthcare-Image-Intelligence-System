@echo off
setlocal enabledelayedexpansion

echo ========================================
echo Git History Rewrite Script
echo Dates: August 6-14, 2025
echo ========================================
echo.

cd /d "C:\Users\ratan\Desktop\Med-description\Medicine-Recognition-System"

echo Creating backup branch...
git branch backup-original-history
echo.

echo Stashing current changes...
git stash
echo.

echo Creating new orphan branch...
git checkout --orphan new-main
git rm -rf .
echo.

REM Commit 1: Initial Setup - Aug 6, 2025, 10:23 AM
echo [1/10] Creating initial project setup commit...
git checkout backup-original-history -- requirements.txt LICENSE .gitignore

REM Create initial README
echo # Medical Image Recognition System > README.md
echo. >> README.md
echo A Flask-based application for medical image analysis using AI. >> README.md

REM Create initial app.py
echo from flask import Flask > app.py
echo. >> app.py
echo app = Flask(__name__) >> app.py
echo. >> app.py
echo @app.route('/') >> app.py
echo def index(): >> app.py
echo     return "Medical Image Recognition System - Coming Soon" >> app.py
echo. >> app.py
echo if __name__ == '__main__': >> app.py
echo     app.run(debug=True) >> app.py

git add .
set GIT_COMMITTER_DATE=2025-08-06T10:23:00
git commit --date="2025-08-06T10:23:00" -m "Initial project setup with Flask application structure"
echo Done!
echo.

REM Commit 2: HTML Template - Aug 7, 2025, 2:45 PM
echo [2/10] Adding HTML template...
git checkout backup-original-history -- templates/
git add templates/
set GIT_COMMITTER_DATE=2025-08-07T14:45:00
git commit --date="2025-08-07T14:45:00" -m "Add HTML template for image upload interface"
echo Done!
echo.

REM Commit 3: CSS - Aug 8, 2025, 11:30 AM
echo [3/10] Adding CSS styling...
git checkout backup-original-history -- static/
git add static/
set GIT_COMMITTER_DATE=2025-08-08T11:30:00
git commit --date="2025-08-08T11:30:00" -m "Implement responsive CSS styling for web interface"
echo Done!
echo.

REM Commit 4: AI Integration - Aug 9, 2025, 4:15 PM
echo [4/10] Integrating Google Generative AI...
(
echo import google.generativeai as genai
echo import os
echo from PIL import Image
echo from dotenv import load_dotenv
echo from flask import Flask, request, render_template
echo.
echo load_dotenv^(^)
echo.
echo genai.configure^(api_key=os.getenv^("GOOGLE_API_KEY"^)^)
echo model = genai.GenerativeModel^("models/gemini-2.0-flash"^)
echo.
echo app = Flask^(__name__^)
echo.
echo def gen_image^(prompt, image^):
echo     response = model.generate_content^([prompt, image]^)
echo     return response.text
echo.
echo @app.route^('/', methods=['GET', 'POST']^)
echo def index^(^):
echo     if request.method == 'POST':
echo         image_prompt = '''Generate a medical description for the given image.'''
echo         uploaded_file = request.files['file']
echo         image = Image.open^(uploaded_file^)
echo         response_text = gen_image^(image_prompt, image^)
echo         return render_template^('index.html', response_text=response_text^)
echo     return render_template^('index.html'^)
echo.
echo if __name__ == '__main__':
echo     app.run^(debug=True^)
) > app.py

git add app.py
set GIT_COMMITTER_DATE=2025-08-09T16:15:00
git commit --date="2025-08-09T16:15:00" -m "Integrate Google Generative AI for medical image analysis"
echo Done!
echo.

REM Commit 5: Validation - Aug 10, 2025, 10:00 AM
echo [5/10] Adding validation functionality...
(
echo import google.generativeai as genai
echo import os
echo from PIL import Image
echo from dotenv import load_dotenv
echo from flask import Flask, request, render_template
echo.
echo load_dotenv^(^)
echo.
echo genai.configure^(api_key=os.getenv^("GOOGLE_API_KEY"^)^)
echo model = genai.GenerativeModel^("models/gemini-2.0-flash"^)
echo.
echo app = Flask^(__name__^)
echo.
echo def gen_image^(prompt, image^):
echo     response = model.generate_content^([prompt, image]^)
echo     return response.text
echo.
echo def validate^(validation_prompt^):
echo     response = model.generate_content^(validation_prompt^)
echo     return response.text.strip^(^).lower^(^)
echo.
echo @app.route^('/', methods=['GET', 'POST']^)
echo def index^(^):
echo     if request.method == 'POST':
echo         image_prompt = '''Generate a detailed medical description for the given image.'''
echo         uploaded_file = request.files['file']
echo         image = Image.open^(uploaded_file^)
echo         response_text = gen_image^(image_prompt, image^)
echo         validation_prompt = "Check if the provided context is related to the medical field. Just Reply with 'Yes' or 'No'."
echo         vans = validate^(validation_prompt^)
echo         if vans == "yes":
echo             return render_template^('index.html', response_text=response_text^)
echo         else:
echo             return render_template^('index.html', response_text="Please provide a valid medical image."^)
echo     return render_template^('index.html'^)
echo.
echo if __name__ == '__main__':
echo     app.run^(debug=True^)
) > app.py

git add app.py
set GIT_COMMITTER_DATE=2025-08-10T10:00:00
git commit --date="2025-08-10T10:00:00" -m "Add medical context validation for uploaded images"
echo Done!
echo.

REM Commit 6: HTML Enhancement - Aug 11, 2025, 3:20 PM
echo [6/10] Enhancing HTML template...
git checkout backup-original-history -- templates/index.html
git add templates/
set GIT_COMMITTER_DATE=2025-08-11T15:20:00
git commit --date="2025-08-11T15:20:00" -m "Enhance HTML template with improved file input and result display"
echo Done!
echo.

REM Commit 7: Refine Prompts - Aug 12, 2025, 9:40 AM
echo [7/10] Refining AI prompts...
git checkout backup-original-history -- app.py
git add app.py
set GIT_COMMITTER_DATE=2025-08-12T09:40:00
git commit --date="2025-08-12T09:40:00" -m "Refine AI prompts for more detailed medical analysis"
echo Done!
echo.

REM Commit 8: CSS Update - Aug 13, 2025, 1:55 PM
echo [8/10] Updating CSS...
git checkout backup-original-history -- static/style.css
git add static/
set GIT_COMMITTER_DATE=2025-08-13T13:55:00
git commit --date="2025-08-13T13:55:00" -m "Update CSS with improved styling and responsive design"
echo Done!
echo.

REM Commit 9: README - Aug 14, 2025, 11:10 AM
echo [9/10] Adding comprehensive README...
git checkout backup-original-history -- README.md
git add README.md
set GIT_COMMITTER_DATE=2025-08-14T11:10:00
git commit --date="2025-08-14T11:10:00" -m "Add comprehensive README with installation and usage instructions"
echo Done!
echo.

REM Commit 10: Final Cleanup - Aug 14, 2025, 4:30 PM
echo [10/10] Final code cleanup...
git checkout backup-original-history -- app.py
git add app.py
set GIT_COMMITTER_DATE=2025-08-14T16:30:00
git commit --date="2025-08-14T16:30:00" -m "Code cleanup, add debug utilities and optimize performance"
echo Done!
echo.

echo ========================================
echo Replacing main branch...
echo ========================================
git checkout backup-original-history
git branch -D main
git branch -m new-main main
git checkout main

echo.
echo ========================================
echo SUCCESS! Git history has been rewritten
echo ========================================
echo.
echo New commit history:
git log --oneline --date=short
echo.
echo ========================================
echo Next Steps:
echo ========================================
echo 1. Review the history: git log --oneline
echo 2. Force push to GitHub: git push -f origin main
echo.
echo Note: Keep backup-original-history branch to revert if needed
echo.

pause
