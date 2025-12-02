from pydantic import BaseSettings

class Settings(BaseSettings):
    SECRET_KEY: str = 'changeme'
    DATABASE_URL: str = 'postgresql://user:pass@localhost:5432/andts'
    REDIS_URL: str = 'redis://localhost:6379'

    class Config:
        env_file = '.env'

settings = Settings()
