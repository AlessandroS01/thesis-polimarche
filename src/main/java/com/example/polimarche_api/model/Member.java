package com.example.polimarche_api.model;

import jakarta.persistence.*;

import java.util.Date;
import java.util.Objects;

@Entity
@Table(name="membro")
public class Member {

    @Id
    @Column(name = "matricola", nullable = false)
    private Integer matricola;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "nome", nullable = false)
    private String nome;

    @Column(name = "cognome", nullable = false)
    private String cognome;

    @Column(name = "data_di_nascita", nullable = false)
    private Date data_di_nascita;

    @Column(name = "email", nullable = false)
    private String email;

    @Column(name = "numero_telefono", nullable = false)
    private String numero_telefono;

    @Column(name = "ruolo", nullable = false)
    private String ruolo;

    @ManyToOne
    @JoinColumn(name = "reparto")
    private Workshop reparto;



    public Member() {
    }

    public Member(Integer matricola, String password, String nome, String cognome, Date data_di_nascita, String email, String numero_telefono, String ruolo, Workshop reparto) {
        this.matricola = matricola;
        this.password = password;
        this.nome = nome;
        this.cognome = cognome;
        this.data_di_nascita = data_di_nascita;
        this.email = email;
        this.numero_telefono = numero_telefono;
        this.ruolo = ruolo;
        this.reparto = reparto;
    }
    public Member(Integer matricola, String password, String nome, String cognome, Date data_di_nascita, String email, String numero_telefono, String ruolo) {
        this.matricola = matricola;
        this.password = password;
        this.nome = nome;
        this.cognome = cognome;
        this.data_di_nascita = data_di_nascita;
        this.email = email;
        this.numero_telefono = numero_telefono;
        this.ruolo = ruolo;
        this.reparto = null;
    }

    public Integer getMatricola() {
        return matricola;
    }

    public void setMatricola(Integer matricola) {
        this.matricola = matricola;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }

    public String getCognome() {
        return cognome;
    }

    public void setCognome(String cognome) {
        this.cognome = cognome;
    }

    public Date getData_di_nascita() {
        return data_di_nascita;
    }

    public void setData_di_nascita(Date data_di_nascita) {
        this.data_di_nascita = data_di_nascita;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getNumero_telefono() {
        return numero_telefono;
    }

    public void setNumero_telefono(String numero_telefono) {
        this.numero_telefono = numero_telefono;
    }

    public String getRuolo() {
        return ruolo;
    }

    public void setRuolo(String ruolo) {
        this.ruolo = ruolo;
    }

    public Workshop getReparto() {
        return reparto;
    }

    public void setReparto(Workshop reparto) {
        this.reparto = reparto;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Member member = (Member) o;
        return Objects.equals(matricola, member.matricola) && Objects.equals(password, member.password) && Objects.equals(nome, member.nome) && Objects.equals(cognome, member.cognome) && Objects.equals(data_di_nascita, member.data_di_nascita) && Objects.equals(email, member.email) && Objects.equals(numero_telefono, member.numero_telefono) && Objects.equals(ruolo, member.ruolo) && Objects.equals(reparto, member.reparto);
    }

    @Override
    public int hashCode() {
        return Objects.hash(matricola, password, nome, cognome, data_di_nascita, email, numero_telefono, ruolo, reparto);
    }

    @Override
    public String toString() {
        return "Member{" +
                "matricola=" + matricola +
                ", password='" + password + '\'' +
                ", nome='" + nome + '\'' +
                ", cognome='" + cognome + '\'' +
                ", data_di_nascita=" + data_di_nascita +
                ", email='" + email + '\'' +
                ", numero_telefono='" + numero_telefono + '\'' +
                ", ruolo='" + ruolo + '\'' +
                ", reparto=" + reparto +
                '}';
    }
}
