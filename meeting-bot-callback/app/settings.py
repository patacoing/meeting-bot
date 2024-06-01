from pydantic_settings import BaseSettings


class Settings(BaseSettings):
    WEBHOOK_URL: str = ""
    DEBUG: bool = False

    model_config = {
        "env_file": ".env"
    }


settings = Settings()
