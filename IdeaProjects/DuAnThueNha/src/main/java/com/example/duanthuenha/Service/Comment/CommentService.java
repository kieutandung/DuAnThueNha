package com.example.duanthuenha.Service.Comment;

import com.example.duanthuenha.Model.Comment;

import java.util.List;

public interface CommentService {
    List<Comment> getCommentsByProductId(int idProduct);
    boolean addComment(int userId, int productId, String comment);
}
