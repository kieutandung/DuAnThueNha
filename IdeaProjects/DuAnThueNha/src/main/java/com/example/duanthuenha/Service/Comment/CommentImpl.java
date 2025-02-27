package com.example.duanthuenha.Service.Comment;

import com.example.duanthuenha.ConnectDB.ConnectDB;
import com.example.duanthuenha.Model.Comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class CommentImpl implements CommentService {
    private ConnectDB connectDB = new ConnectDB();

    @Override
    public List<Comment> getCommentsByProductId(int idProduct) {
        List<Comment> comments = new ArrayList<>();
        String sql = "SELECT c.idComment, c.comment, c.commentDate, u.username " +
                "FROM commentproduct c " +
                "JOIN users u ON c.userId = u.idUser " +
                "WHERE c.idProduct = ? " +
                "ORDER BY c.commentDate DESC";

        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, idProduct);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Comment comment = new Comment();
                comment.setIdComment(rs.getInt("idComment"));
                comment.setUsername(rs.getString("username"));
                comment.setComment(rs.getString("comment"));
                comment.setCommentDate(rs.getTimestamp("commentDate").toLocalDateTime());
                comments.add(comment);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return comments;
    }

    public boolean addComment(int userId, int productId, String comment) {
        String sql = "INSERT INTO commentproduct (userId, idProduct, comment, commentDate) VALUES (?, ?, ?, NOW())";
        try (Connection conn = connectDB.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, productId);
            stmt.setString(3, comment);

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
