package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.sql.Time;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name="commento")
public class Comment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;
    private String flag;
    private String descrizione;
    @ManyToOne
    @JoinColumn(name = "sessione")
    private PracticeSession sessione;


    public Comment() {

    }

    public Comment(Integer id, String flag, String descrizione, PracticeSession sessione) {
        this.id = id;
        this.flag = flag;
        this.descrizione = descrizione;
        this.sessione = sessione;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFlag() {
        return flag;
    }

    public void setFlag(String flag) {
        this.flag = flag;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    public PracticeSession getSessione() {
        return sessione;
    }

    public void setSessione(PracticeSession sessione) {
        this.sessione = sessione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment = (Comment) o;
        return Objects.equals(id, comment.id) && Objects.equals(flag, comment.flag) && Objects.equals(descrizione, comment.descrizione) && Objects.equals(sessione, comment.sessione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, flag, descrizione, sessione);
    }

    @Override
    public String toString() {
        return "Comment{" +
                "id=" + id +
                ", flag='" + flag + '\'' +
                ", descrizione='" + descrizione + '\'' +
                ", sessione=" + sessione +
                '}';
    }
}
