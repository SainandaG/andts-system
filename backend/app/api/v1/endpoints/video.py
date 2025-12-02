from fastapi import APIRouter
router = APIRouter()

@router.get('/')
def placeholder():
    return {'endpoint': 'video', 'status': 'placeholder'}
