package com.example.duanthuenha.Model;

import java.time.LocalDateTime;

public class Comment {
    private int idComment;
    private int idProduct;
    private int userId;
    private String username;
    private String comment;
    private LocalDateTime commentDate;
    // Constructors
    public Comment() {}

    public Comment(int idComment, int idProduct, int userId, String username, String comment, LocalDateTime commentDate) {
        this.idComment = idComment;
        this.idProduct = idProduct;
        this.userId = userId;
        this.username = username;
        this.comment = comment;
        this.commentDate = commentDate;
    }

    public int getIdComment() { return idComment; }
    public void setIdComment(int idComment) { this.idComment = idComment; }

    public int getIdProduct() { return idProduct; }
    public void setIdProduct(int idProduct) { this.idProduct = idProduct; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getComment() { return comment; }
    public void setComment(String comment) { this.comment = comment; }

    public LocalDateTime getCommentDate() { return commentDate; }
    public void setCommentDate(LocalDateTime commentDate) { this.commentDate = commentDate; }
}
