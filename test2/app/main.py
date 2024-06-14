from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import logs

app = FastAPI()

blog_posts = []

class BlogPost(BaseModel):
    id: int
    title: str
    content: str

@app.post('/app/blog')
def create_blog_post(post: BlogPost):
    try:
        blog_posts.append(post)
        return {'status': 'success'}
    except Exception as e:
        logs.log_error(str(e))
        raise HTTPException(status_code=500, detail=str(e))

@app.get('/app/blog')
def get_blog_posts():
    if len(blog_posts) == 0:
        logs.log_warning('No posts found')
        raise HTTPException(status_code=404, detail='No posts found')
    else:
        return {'posts': blog_posts}

@app.get('/app/blog/{id}')
def get_blog_post(id: int):
    for post in blog_posts:
        if post.id == id:
            return {'post': post}
    logs.log_warning(f'Post with id {id} not found')
    raise HTTPException(status_code=404, detail='Post not found')

@app.delete('/app/blog/{id}')
def delete_blog_post(id: int):
    for post in blog_posts:
        if post.id == id:
            blog_posts.remove(post)
            return {'status': 'success'}
    logs.log_warning(f'Post with id {id} not found')
    raise HTTPException(status_code=404, detail='Post not found')

@app.put('/app/blog/{id}')
def update_blog_post(id: int, post: BlogPost):
    for existing_post in blog_posts:
        if existing_post.id == id:
            existing_post.title = post.title
            existing_post.content = post.content
            return {'status': 'success'}
    logs.log_warning(f'Post with id {id} not found')
    raise HTTPException(status_code=404, detail='Post not found')
