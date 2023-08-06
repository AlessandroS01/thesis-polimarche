package com.example.polimarche_api.service;

import com.example.polimarche_api.exception.ResourceNotFoundException;
import com.example.polimarche_api.model.BreakageHappen;
import com.example.polimarche_api.model.Comment;
import com.example.polimarche_api.model.records.NewComment;
import com.example.polimarche_api.repository.BreakageHappenRepository;
import com.example.polimarche_api.repository.CommentRepository;
import jakarta.persistence.criteria.CriteriaBuilder;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.ArgumentCaptor;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;

import java.util.Optional;

import static org.assertj.core.api.AssertionsForClassTypes.assertThat;
import static org.assertj.core.api.AssertionsForClassTypes.assertThatThrownBy;
import static org.junit.jupiter.api.Assertions.*;
import static org.mockito.BDDMockito.given;
import static org.mockito.Mockito.mock;
import static org.mockito.Mockito.verify;

@ExtendWith(MockitoExtension.class)
class CommentServiceTest {

    @Mock // simulate the behaviour of a real instance of BreakageHappenRepository
    private CommentRepository commentRepository; // this class is generated without any error
    private CommentService underTest;

    @BeforeEach
    void setUp() {
        this.underTest = new CommentService(commentRepository);
    }

    @Test
    void canRecordReader() {
        //given
        NewComment request = mock(NewComment.class);

        //when
        Comment comment = underTest.recordReader(request);

        //then
        assertNotNull(comment);
        assertThat(request.sessione()).isEqualTo(comment.getSessione());
        assertThat(request.flag()).isEqualTo(comment.getFlag());
        assertThat(request.descrizione()).isEqualTo(comment.getDescrizione());
    }

    @Test
    void canGetAllComments() {
        //when
        underTest.getAllComments();

        //then
        verify(commentRepository).findAll();
    }

    @Test
    void canGetCommentsBySession() {
        //given
        Integer id = 1;
        given(commentRepository.existsCommentBySessioneId(id)).willReturn(true);

        //when
        underTest.getCommentsBySession(id);

        //then
        verify(commentRepository).existsCommentBySessioneId(id);
    }
    @Test
    void canNotGetCommentsBySession() {
        //given
        Integer id = 1;

        //when, then
        assertThatThrownBy(() -> underTest.getCommentsBySession(id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Comments not found for session ID: " + id);
    }

    @Test
    void addNewComment() {
        //given
        NewComment request = mock(NewComment.class);

        //when
        underTest.addNewComment(request);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Comment> commentArgumentCaptor = ArgumentCaptor.forClass(Comment.class);
        verify(commentRepository).save(commentArgumentCaptor.capture());

        // Get the captured Balance object
        Comment commentSaved = commentArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.flag()).isEqualTo(commentSaved.getFlag());
        assertThat(request.sessione()).isEqualTo(commentSaved.getSessione());
        assertThat(request.descrizione()).isEqualTo(commentSaved.getDescrizione());
    }

    @Test
    void canModifyComment() {
        //given
        Integer id = 1;
        given(commentRepository.findById(id))
                .willReturn(
                        Optional.of(
                                mock(Comment.class)
                        )
                );
        NewComment request = mock(NewComment.class);

        //when
        underTest.modifyComment(request, id);

        //then

        // Capture the argument passed to balanceRepository.save
        ArgumentCaptor<Comment> commentArgumentCaptor = ArgumentCaptor.forClass(Comment.class);
        verify(commentRepository).save(commentArgumentCaptor.capture());

        // Get the captured Balance object
        Comment commentSaved = commentArgumentCaptor.getValue();

        // Verify that the properties of the captured Balance object match the expected properties
        assertThat(request.flag()).isEqualTo(commentSaved.getFlag());
        assertThat(request.sessione()).isEqualTo(commentSaved.getSessione());
        assertThat(request.descrizione()).isEqualTo(commentSaved.getDescrizione());
    }

    @Test
    void canNotModifyComment() {
        //given
        Integer id = 1;
        NewComment request = mock(NewComment.class);

        //when, then
        assertThatThrownBy(() -> underTest.modifyComment(request, id))
                .isInstanceOf(ResourceNotFoundException.class)
                .hasMessageContaining("Comment " + id + " doesn't exist.");
    }
}