from pydantic import BaseModel, field_validator
from enum import Enum
import re

from .custom_logging import logger


class Action(Enum):
    PING = "ping"


class Event(BaseModel):
    action: Action
    description: str
    name: str
    time: str

    @classmethod
    @field_validator("time")
    def time_must_be_valid(cls, v):
        if not re.search(r"^\d{2}:\d{2}$", v):
            logger.error(f"Invalid time: {v}")
            raise ValueError("Time must be a valid string")
        return v
