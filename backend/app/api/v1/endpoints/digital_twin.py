from fastapi import APIRouter
router = APIRouter()

@router.get('/')
def placeholder():
    return {'endpoint': 'digital_twin', 'status': 'placeholder'}
