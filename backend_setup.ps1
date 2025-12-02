Write-Host "🔥 ANDTS Backend Setup Starting..."

# create backend folder INSIDE current directory always
$backendPath = Join-Path (Get-Location) "backend"
New-Item -ItemType Directory -Force -Path $backendPath | Out-Null

# switch into backend
Set-Location $backendPath

Write-Host "📁 Creating backend folder structure..."

$folders = @(
    "app/api/v1/endpoints",
    "app/api/v1/schemas",
    "app/services",
    "app/database/models",
    "app/ml",
    "app/graph/queries",
    "app/core",
    "docker",
    "tests"
)

foreach ($f in $folders) {
    New-Item -ItemType Directory -Force -Path $f | Out-Null
}

Write-Host "📄 Creating backend files..."

# requirements.txt
@"
fastapi
uvicorn
pydantic
python-dotenv
SQLAlchemy
psycopg2
redis
neo4j
httpx
opencv-python
python-multipart
numpy
scikit-learn
pillow
pytest
pytest-asyncio
"@ | Set-Content "requirements.txt"

# pytest.ini
@"
[pytest]
addopts = -ra -q
testpaths = tests
"@ | Set-Content "pytest.ini"

# .gitignore
@"
__pycache__/
*.pyc
.env
venv/
"@ | Set-Content ".gitignore"

# .env files
"SECRET_KEY=changeme" | Set-Content ".env"
"SECRET_KEY=changeme" | Set-Content ".env.example"

# main.py
@"
from fastapi import FastAPI
from app.api.v1.router import api_router

app = FastAPI(title='ANDTS Backend API')
app.include_router(api_router, prefix='/api/v1')

@app.get('/')
def root():
    return {'message': 'ANDTS Backend Running'}
"@ | Set-Content "app/main.py"

# config.py
@"
from pydantic import BaseSettings

class Settings(BaseSettings):
    SECRET_KEY: str = 'changeme'
    DATABASE_URL: str = 'postgresql://user:pass@localhost:5432/andts'
    REDIS_URL: str = 'redis://localhost:6379'

    class Config:
        env_file = '.env'

settings = Settings()
"@ | Set-Content "app/config.py"

# router
@"
from fastapi import APIRouter
from app.api.v1.endpoints import *
api_router = APIRouter()
"@ | Set-Content "app/api/v1/router.py"

# endpoints
$endpoints = @(
    "auth","farms","plots","video","ml_inference",
    "predictions","recommendations","graph_queries",
    "digital_twin","market","notifications"
)

foreach ($ep in $endpoints) {
@"
from fastapi import APIRouter
router = APIRouter()

@router.get('/')
def placeholder():
    return {'endpoint': '$ep', 'status': 'placeholder'}
"@ | Set-Content "app/api/v1/endpoints/$ep.py"
}

Write-Host "🎉 Backend generated successfully!"
