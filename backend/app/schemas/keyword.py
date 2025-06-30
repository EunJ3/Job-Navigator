# backend/app/schemas/keyword.py

from pydantic import BaseModel
from typing import List

class KeywordOut(BaseModel):
    file_id: str
    filename: str
    keywords: List[str]

    class Config:
        orm_mode = True
