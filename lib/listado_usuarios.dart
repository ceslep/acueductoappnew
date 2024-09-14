import 'package:acueductoapp/aso_usuarios_model.dart';
import 'package:acueductoapp/map_view_user.dart';
import 'package:flutter/material.dart';

class ListadoUsuarios extends StatefulWidget {
  final List<AsoUsuarios> asoUsuarios;
  const ListadoUsuarios({super.key, required this.asoUsuarios});

  @override
  State<ListadoUsuarios> createState() => _ListadoUsuariosState();
}

class _ListadoUsuariosState extends State<ListadoUsuarios> {
  List<AsoUsuarios> _asoUsuarios = [];
  TextEditingController busquedaController = TextEditingController();
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
        itemCount: _asoUsuarios.length + 1,
        itemBuilder: (context, index) {
          int indexx = index - 1;
          String tipoSitio;
          String nombre;
          String tipoTarifa;
          String identificacion;
          String numeroPersonas;
          AsoUsuarios asoUsuario;
          // Verifica si la lista no es nula o está vacía
          if (widget.asoUsuarios.isEmpty) {
            return const Center(
              child: Text('No hay usuarios disponibles'),
            );
          }

          // Obtiene el nombre de la finca o usa un valor predeterminado si es nulo
          if (index >= 1) {
            tipoSitio = _asoUsuarios[indexx].siteType ?? 'Sin nombre';
            nombre = _asoUsuarios[indexx].ownerName ?? 'Sin nombre';

            tipoTarifa = _asoUsuarios[indexx].siteTarife ?? 'Sin nombre';

            identificacion = _asoUsuarios[indexx].ownerId ?? 'Sin nombre';

            numeroPersonas = _asoUsuarios[indexx].numberPersons ?? 'Sin nombre';

            asoUsuario = _asoUsuarios[indexx];
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _asoUsuarios = widget.asoUsuarios
                        .where(
                          (usuario) =>
                              usuario.ownerName!.toLowerCase().contains(
                                    value.toLowerCase(),
                                  ) ||
                              usuario.ownerId!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()),
                        )
                        .toList();
                  });
                },
                controller: busquedaController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Buscar',
                  hintText: 'Buscar Usuario',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),
                    onPressed: () {
                      // Aquí puedes implementar la lógica para limpiar el campo de texto
                      busquedaController.text = '';
                      setState(() {
                        _asoUsuarios = widget.asoUsuarios;
                      });
                    },
                  ),
                ),
              ),
            );
          }

          return Card(
            child: ListTile(
              leading: Column(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context, asoUsuario);
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.deepPurple,
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ViewMapUser(asoUsuario: asoUsuario)),
                  );
                },
                icon:
                    const Icon(Icons.map_sharp, color: Colors.deepOrangeAccent),
              ),
              title: Row(
                children: [
                  Text(
                    '$index:',
                    style: const TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    nombre,
                    style: const TextStyle(
                        color: Color.fromARGB(255, 71, 102, 21),
                        fontWeight: FontWeight.bold),
                  ),
                ],
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
