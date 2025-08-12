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