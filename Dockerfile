FROM python:3.9
RUN useradd -m -u 1000 user
USER user
ENV HOME=/home/user \
    PATH=/home/user/.local/bin:$PATH

# Add explicit environment variable
ENV OPENAI_API_KEY=${OPENAI_API_KEY}

WORKDIR $HOME/app
COPY --chown=user . $HOME/app
COPY ./requirements.txt ~/app/requirements.txt
RUN pip install -r requirements.txt
COPY . .
COPY .env .env
CMD ["chainlit", "run", "app.py", "--host", "0.0.0.0", "--port", "7860"]
