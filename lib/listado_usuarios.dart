import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:flutter/material.dart';

class ListadoUsuarios extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;
  const ListadoUsuarios({super.key, required this.asoUsuarios});

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text(
          'Listado de Usuarios',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.asoUsuarios.length,
        itemBuilder: (context, index) {
          // Verifica si la lista no es nula o está vacía
          if (widget.asoUsuarios.isEmpty) {
            return const Center(
              child: Text('No hay usuarios disponibles'),
            );
          }

          // Obtiene el nombre de la finca o usa un valor predeterminado si es nulo
          final String tipoSitio =
              widget.asoUsuarios[index].siteType ?? 'Sin nombre';
          final String nombre =
              widget.asoUsuarios[index].ownerName ?? 'Sin nombre';

          final String tipoTarifa =
              widget.asoUsuarios[index].siteTarife ?? 'Sin nombre';

          final String identificacion =
              widget.asoUsuarios[index].ownerId ?? 'Sin nombre';

          return Card(
            child: ListTile(
              title: Text('Usuario: $nombre'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Tipo de sitio: $tipoSitio',
                    style: const TextStyle(
                        color: Colors.blueGrey, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Tipo de tarifa: $tipoTarifa',
                    style: const TextStyle(
                        color: Colors.blueGrey, fontStyle: FontStyle.italic),
                  ),
                  Text(
                    'Identificación: $identificacion',
                    style: const TextStyle(
                        color: Colors.blueGrey, fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
