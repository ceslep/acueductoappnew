import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:flutter/material.dart';

class ListadoUsuarios extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;
  const ListadoUsuarios({super.key, required this.asoUsuarios});

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  List<AsoUsuarios> _asoUsuarios = [];
  @override
  void initState() {
    super.initState();
    widget.asoUsuarios.sort(((a, b) => a.ownerName!.compareTo(b.ownerName!)));
    _asoUsuarios = widget.asoUsuarios;
  }

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
        itemCount: _asoUsuarios.length,
        itemBuilder: (context, index) {
          // Verifica si la lista no es nula o está vacía
          if (widget.asoUsuarios.isEmpty) {
            return const Center(
              child: Text('No hay usuarios disponibles'),
            );
          }

          // Obtiene el nombre de la finca o usa un valor predeterminado si es nulo
          final String tipoSitio = _asoUsuarios[index].siteType ?? 'Sin nombre';
          final String nombre = _asoUsuarios[index].ownerName ?? 'Sin nombre';

          final String tipoTarifa =
              _asoUsuarios[index].siteTarife ?? 'Sin nombre';

          final String identificacion =
              _asoUsuarios[index].ownerId ?? 'Sin nombre';

          final String numeroPersonas =
              _asoUsuarios[index].numberPersons ?? 'Sin nombre';

          return Card(
            child: ListTile(
              leading: Text((index + 1).toString()),
              trailing: IconButton(
                onPressed: () {},
                icon:
                    const Icon(Icons.map_sharp, color: Colors.deepOrangeAccent),
              ),
              title: Text(
                'Usuario: $nombre',
                style: const TextStyle(
                    color: Colors.deepPurple, fontWeight: FontWeight.bold),
              ),
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
                  Text(
                    'Número de Personas: $numeroPersonas',
                    style: const TextStyle(
                        color: Color.fromARGB(255, 22, 116, 3),
                        fontStyle: FontStyle.italic),
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
