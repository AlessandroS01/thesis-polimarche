package com.example.polimarche_api.model;

import jakarta.persistence.*;
import jakarta.persistence.criteria.CriteriaBuilder;

import java.sql.Time;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name="nota")
public class Nota {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Date data;
    private Time ora_inizio;
    private Time ora_fine;
    @ManyToOne
    @JoinColumn(name = "membro")
    private Member membro;
    private String descrizione;


    public Nota(Integer id, Date data, Time ora_inizio, Time ora_fine, Member membro, String descrizione) {
        this.id = id;
        this.data = data;
        this.ora_inizio = ora_inizio;
        this.ora_fine = ora_fine;
        this.membro = membro;
        this.descrizione = descrizione;
    }

    public Nota() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getData() {
        return data;
    }

    public void setData(Date data) {
        this.data = data;
    }

    public Time getOra_inizio() {
        return ora_inizio;
    }

    public void setOra_inizio(Time ora_inizio) {
        this.ora_inizio = ora_inizio;
    }

    public Time getOra_fine() {
        return ora_fine;
    }

    public void setOra_fine(Time ora_fine) {
        this.ora_fine = ora_fine;
    }

    public Member getMembro() {
        return membro;
    }

    public void setMembro(Member membro) {
        this.membro = membro;
    }

    public String getDescrizione() {
        return descrizione;
    }

    public void setDescrizione(String descrizione) {
        this.descrizione = descrizione;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Nota nota = (Nota) o;
        return Objects.equals(id, nota.id) && Objects.equals(data, nota.data) && Objects.equals(ora_inizio, nota.ora_inizio) && Objects.equals(ora_fine, nota.ora_fine) && Objects.equals(membro, nota.membro) && Objects.equals(descrizione, nota.descrizione);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, data, ora_inizio, ora_fine, membro, descrizione);
    }

    @Override
    public String toString() {
        return "Nota{" +
                "id=" + id +
                ", data=" + data +
                ", ora_inizio=" + ora_inizio +
                ", ora_fine=" + ora_fine +
                ", membro=" + membro +
                ", descrizione='" + descrizione + '\'' +
                '}';
    }
}
