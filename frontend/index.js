import { backend } from "declarations/backend";

document.addEventListener('DOMContentLoaded', async () => {
    const loading = document.getElementById('loading');
    const postsContainer = document.getElementById('posts-container');

    const showLoading = () => {
        loading.classList.remove('d-none');
    };

    const hideLoading = () => {
        loading.classList.add('d-none');
    };

    const formatDate = (timestamp) => {
        return new Date(Number(timestamp) / 1000000).toLocaleDateString('en-US', {
            year: 'numeric',
            month: 'long',
            day: 'numeric'
        });
    };

    const renderPosts = (posts) => {
        postsContainer.innerHTML = posts.map(post => `
            <article class="blog-post">
                <h2 class="blog-post-title">${post.title}</h2>
                <p class="blog-post-meta">${formatDate(post.timestamp)}</p>
                ${post.content.split('\n\n').map(paragraph => `<p>${paragraph}</p>`).join('')}
            </article>
        `).join('');
    };

    try {
        showLoading();
        // Initialize content if needed
        await backend.initializeContent();
        // Fetch posts
        const posts = await backend.getPosts();
        renderPosts(posts);
    } catch (error) {
        console.error('Error:', error);
        postsContainer.innerHTML = '<div class="alert alert-danger">Error loading blog posts</div>';
    } finally {
        hideLoading();
    }
});
