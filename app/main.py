from fastapi import FastAPI, Request, Depends, HTTPException
from fastapi.responses import HTMLResponse, RedirectResponse
from fastapi.staticfiles import StaticFiles
from fastapi.templating import Jinja2Templates
from fastapi.middleware.cors import CORSMiddleware
from .database import Base, engine, get_db
from .routers.shortener import router as shortener_router
from . import crud
import os

app = FastAPI(title="URL Shortener", version="1.0.0")

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)
BASE_DIR = os.path.dirname(os.path.abspath(__file__))

app.mount("/static", StaticFiles(directory=os.path.join(BASE_DIR, "static")), name="static")
templates = Jinja2Templates(directory=os.path.join(BASE_DIR, "templates"))


@app.on_event("startup")
async def on_startup():
    Base.metadata.create_all(bind=engine)

@app.get("/health")
def health():
    return {"status": "ok"}

@app.get("/", response_class=HTMLResponse)
async def home(request: Request):
    return templates.TemplateResponse("index.html", {"request": request})

app.include_router(shortener_router, prefix="/shorten", tags=["Shortener"])

@app.get("/{code}")
def redirect_root(code: str, db=Depends(get_db)):
    obj = crud.get_by_code(db, code)
    if not obj:
        raise HTTPException(status_code=404, detail="Short code not found")
    crud.increment_click(db, obj)
    return RedirectResponse(obj.original_url, status_code=307)
