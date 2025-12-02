from fastapi import APIRouter
router = APIRouter()

@router.get('/')
def placeholder():
    return {'endpoint': 'ml_inference', 'status': 'placeholder'}
