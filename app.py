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
        uploaded_file = request.files['file']
        image = Image.open(uploaded_file)
        prompt = 'Generate a medical description for this image.'
        result = gen_image(prompt, image)
        return render_template('index.html', response_text=result)
    return render_template('index.html')

if __name__ == '__main__':
    app.run(debug=True)
