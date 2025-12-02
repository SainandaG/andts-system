from fastapi import APIRouter
router = APIRouter()

@router.get('/')
def placeholder():
    return {'endpoint': 'recommendations', 'status': 'placeholder'}
