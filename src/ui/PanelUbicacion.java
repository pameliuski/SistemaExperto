/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package ui;

import java.awt.event.ActionListener;

/**
 *
 * @author Nicole
 */
@SuppressWarnings("serial")
public class PanelUbicacion extends javax.swing.JPanel {
    /**
     * Creates new form PanelPrincipal
     */
    public PanelUbicacion() {
        initComponents();
    }

    /**
     * This method is called from within the constructor to initialize the form.
     * WARNING: Do NOT modify this code. The content of this method is always
     * regenerated by the Form Editor.
     */

    // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
    private void initComponents() {

        labelPregunta = new javax.swing.JLabel();
        comboBoxRespuesta = new javax.swing.JComboBox<>();
        botonSiguiente = new javax.swing.JButton();
        ubicacionImagen = new javax.swing.JLabel();
        labelInformacion = new javax.swing.JLabel();
        labelTitulo = new javax.swing.JLabel();

        setBackground(new java.awt.Color(102, 102, 102));
        setMinimumSize(new java.awt.Dimension(800, 600));
        setPreferredSize(new java.awt.Dimension(800, 600));

        labelPregunta.setBackground(new java.awt.Color(255, 255, 255));
        labelPregunta.setFont(new java.awt.Font("Tahoma", 1, 18)); // NOI18N
        labelPregunta.setForeground(new java.awt.Color(255, 255, 255));
        labelPregunta.setText("Donde se ubica actualmente?");

        comboBoxRespuesta.setModel(new javax.swing.DefaultComboBoxModel<>(new String[] { "Base Militar La Paz", "Base Militar Cochabamba", "Base Militar Santa Cruz", "Base Militar Sucre", "Base Militar Potosi" }));

        botonSiguiente.setText("Siguiente");
        botonSiguiente.setName("botonUbicacionSiguiente"); // NOI18N
        botonSiguiente.addActionListener(new java.awt.event.ActionListener() {
            public void actionPerformed(java.awt.event.ActionEvent evt) {
                botonSiguienteActionPerformed(evt);
            }
        });

        ubicacionImagen.setIcon(new javax.swing.ImageIcon(getClass().getResource("/ui/ubicacion.jpg"))); // NOI18N

        labelInformacion.setText("<html>¡Informacion!<br><br>Este paso es necesario para saber la ubicacion inicial del vuelo, con el proposito de vericar si esa ubicacion esta disponible. </html>");

        labelTitulo.setFont(new java.awt.Font("Tahoma", 1, 24)); // NOI18N
        labelTitulo.setForeground(new java.awt.Color(255, 255, 255));
        labelTitulo.setText("Planificacion Aerea Militar");

        javax.swing.GroupLayout layout = new javax.swing.GroupLayout(this);
        this.setLayout(layout);
        layout.setHorizontalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
                .addContainerGap(30, Short.MAX_VALUE)
                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                    .addComponent(botonSiguiente)
                    .addGroup(layout.createSequentialGroup()
                        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                            .addGroup(layout.createSequentialGroup()
                                .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
                                    .addComponent(labelPregunta, javax.swing.GroupLayout.PREFERRED_SIZE, 292, javax.swing.GroupLayout.PREFERRED_SIZE)
                                    .addComponent(comboBoxRespuesta, javax.swing.GroupLayout.PREFERRED_SIZE, 292, javax.swing.GroupLayout.PREFERRED_SIZE))
                                .addGap(26, 26, 26))
                            .addGroup(javax.swing.GroupLayout.Alignment.LEADING, layout.createSequentialGroup()
                                .addComponent(labelTitulo)
                                .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED))
                            .addGroup(layout.createSequentialGroup()
                                .addComponent(labelInformacion, javax.swing.GroupLayout.PREFERRED_SIZE, 300, javax.swing.GroupLayout.PREFERRED_SIZE)
                                .addGap(18, 18, 18)))
                        .addComponent(ubicacionImagen, javax.swing.GroupLayout.PREFERRED_SIZE, 392, javax.swing.GroupLayout.PREFERRED_SIZE)))
                .addGap(60, 60, 60))
        );
        layout.setVerticalGroup(
            layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
            .addGroup(layout.createSequentialGroup()
                .addGap(38, 38, 38)
                .addComponent(labelTitulo)
                .addGap(100, 100, 100)
                .addComponent(labelPregunta, javax.swing.GroupLayout.PREFERRED_SIZE, 34, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(31, 31, 31)
                .addComponent(comboBoxRespuesta, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(39, 39, 39)
                .addComponent(labelInformacion, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addContainerGap(javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
            .addGroup(layout.createSequentialGroup()
                .addContainerGap(168, Short.MAX_VALUE)
                .addComponent(ubicacionImagen, javax.swing.GroupLayout.PREFERRED_SIZE, 299, javax.swing.GroupLayout.PREFERRED_SIZE)
                .addGap(40, 40, 40)
                .addComponent(botonSiguiente)
                .addGap(68, 68, 68))
        );
    }// </editor-fold>//GEN-END:initComponents

    private void botonSiguienteActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_botonSiguienteActionPerformed
        // TODO add your handling code here:
    }//GEN-LAST:event_botonSiguienteActionPerformed

    void addOnClickSiguienteEventListener(ActionListener actionListener) {
        this.botonSiguiente.addActionListener(actionListener);
    }

    // Variables declaration - do not modify//GEN-BEGIN:variables
    private javax.swing.JButton botonSiguiente;
    private javax.swing.JComboBox<String> comboBoxRespuesta;
    private javax.swing.JLabel labelInformacion;
    private javax.swing.JLabel labelPregunta;
    private javax.swing.JLabel labelTitulo;
    private javax.swing.JLabel ubicacionImagen;
    // End of variables declaration//GEN-END:variables

    public int getRespuesta() {
        return comboBoxRespuesta.getSelectedIndex();
    }
}
