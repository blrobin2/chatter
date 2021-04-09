# frozen_string_literal: true

class PostsReflex < ApplicationReflex
  def repost
    post = Post.find(element.dataset[:id])
    post.increment! :reposts_counter
    cable_ready['timeline'].text_content(
      selector: "#post-#{post.id}-reposts",
      text: post.reload.reposts_counter
    ).broadcast
  end

  def like
    post = Post.find(element.dataset[:id])
    post.increment! :likes_count
    cable_ready['timeline'].text_content(
      selector: "#post-#{post.id}-likes",
      text: post.reload.likes_count
    ).broadcast
  end
end
