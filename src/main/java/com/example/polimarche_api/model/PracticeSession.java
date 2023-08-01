package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.sql.Time;
import java.sql.Date;
import java.util.Objects;

@Entity
@Table(name = "sessione_pratica",
        uniqueConstraints = @UniqueConstraint(columnNames = {"evento", "data", "ora_inizio", "ora_fine"}))
public class PracticeSession {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "id")
    private Integer id;

    @Column(name = "evento", nullable = false, length = 20)
    private String evento;

    @Column(name = "data", nullable = false)
    private Date data;

    @Column(name = "ora_inizio", nullable = false)
    private Time ora_inizio;

    @Column(name = "ora_fine", nullable = false)
    private Time ora_fine;

    @ManyToOne
    @JoinColumn(name = "tracciato")
    private Track tracciato;

    @Column(name = "meteo", nullable = false, length = 50)
    private String meteo;

    @Column(name = "pressione_atmosferica", nullable = false)
    private Double pressione_atmosferica;

    @Column(name = "temperatura_aria", nullable = false)
    private Double temperatura_aria;

    @Column(name = "temperatura_tracciato", nullable = false)
    private Double temperatura_tracciato;

    @Column(name = "condizione_tracciato", nullable = false, length = 50)
    private String condizione_tracciato;


    public PracticeSession(Integer id, String evento, Date data, Time ora_inizio, Time ora_fine, Track tracciato, String meteo, Double pressione_atmosferica, Double temperatura_aria, Double temperatura_tracciato, String condizione_tracciato) {
        this.id = id;
        this.evento = evento;
        this.data = data;
        this.ora_inizio = ora_inizio;
        this.ora_fine = ora_fine;
        this.tracciato = tracciato;
        this.meteo = meteo;
        this.pressione_atmosferica = pressione_atmosferica;
        this.temperatura_aria = temperatura_aria;
        this.temperatura_tracciato = temperatura_tracciato;
        this.condizione_tracciato = condizione_tracciato;
    }

    public PracticeSession() {

    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getEvento() {
        return evento;
    }

    public void setEvento(String evento) {
        this.evento = evento;
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

    public Track getTracciato() {
        return tracciato;
    }

    public void setTracciato(Track tracciato) {
        this.tracciato = tracciato;
    }

    public String getMeteo() {
        return meteo;
    }

    public void setMeteo(String meteo) {
        this.meteo = meteo;
    }

    public Double getPressione_atmosferica() {
        return pressione_atmosferica;
    }

    public void setPressione_atmosferica(Double pressione_atmosferica) {
        this.pressione_atmosferica = pressione_atmosferica;
    }

    public Double getTemperatura_aria() {
        return temperatura_aria;
    }

    public void setTemperatura_aria(Double temperatura_aria) {
        this.temperatura_aria = temperatura_aria;
    }

    public Double getTemperatura_tracciato() {
        return temperatura_tracciato;
    }

    public void setTemperatura_tracciato(Double temperatura_tracciato) {
        this.temperatura_tracciato = temperatura_tracciato;
    }

    public String getCondizione_tracciato() {
        return condizione_tracciato;
    }

    public void setCondizione_tracciato(String condizione_tracciato) {
        this.condizione_tracciato = condizione_tracciato;
    }

    public void setAll(String evento, Date data, Time ora_inizio, Time ora_fine, Track tracciato, String meteo, Double pressione_atmosferica, Double temperatura_aria, Double temperatura_tracciato, String condizione_tracciato){
        this.evento = evento;
        this.data = data;
        this.ora_inizio = ora_inizio;
        this.ora_fine = ora_fine;
        this.tracciato = tracciato;
        this.meteo = meteo;
        this.pressione_atmosferica = pressione_atmosferica;
        this.temperatura_aria = temperatura_aria;
        this.temperatura_tracciato = temperatura_tracciato;
        this.condizione_tracciato = condizione_tracciato;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        PracticeSession that = (PracticeSession) o;
        return Objects.equals(id, that.id) && Objects.equals(evento, that.evento) && Objects.equals(data, that.data) && Objects.equals(ora_inizio, that.ora_inizio) && Objects.equals(ora_fine, that.ora_fine) && Objects.equals(tracciato, that.tracciato) && Objects.equals(meteo, that.meteo) && Objects.equals(pressione_atmosferica, that.pressione_atmosferica) && Objects.equals(temperatura_aria, that.temperatura_aria) && Objects.equals(temperatura_tracciato, that.temperatura_tracciato) && Objects.equals(condizione_tracciato, that.condizione_tracciato);
    }

    @Override
    public int hashCode() {
        return Objects.hash(id, evento, data, ora_inizio, ora_fine, tracciato, meteo, pressione_atmosferica, temperatura_aria, temperatura_tracciato, condizione_tracciato);
    }

    @Override
    public String toString() {
        return "PracticeSession{" +
                "id=" + id +
                ", evento='" + evento + '\'' +
                ", data=" + data +
                ", ora_inizio=" + ora_inizio +
                ", ora_fine=" + ora_fine +
                ", tracciato=" + tracciato +
                ", meteo='" + meteo + '\'' +
                ", pressione_atmosferica=" + pressione_atmosferica +
                ", temperatura_aria=" + temperatura_aria +
                ", temperatura_tracciato=" + temperatura_tracciato +
                ", condizione_tracciato='" + condizione_tracciato + '\'' +
                '}';
    }
}
