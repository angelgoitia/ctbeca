import 'package:ctbeca/models/admin.dart';
import 'package:ctbeca/models/animal.dart';
import 'package:ctbeca/models/player.dart';
import 'package:ctbeca/models/slp.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io'as io;
import 'dart:async';

class DBctbeca{

  static Database? dbInstance;
  static int versionDB = 2;

  Future<Database> get db async{
    if(dbInstance == null)
      dbInstance = await initDB();

    return dbInstance!;


  }

  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "ctbeca.db");

    var db = await openDatabase(path, version: versionDB, 
      onCreate: onCreateFunc,
      onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion != newVersion) {
            onCreateFunc(db, newVersion);
          }
        },
    );

    return db;
  }


  void onCreateFunc(Database db, int version) async{
    //create table
    await db.execute('CREATE TABLE IF NOT EXISTS admin (id INTEGER PRIMARY KEY AUTOINCREMENT, accessToken Text, tokenFCM Text)');
    await db.execute('CREATE TABLE IF NOT EXISTS animals (id INTEGER, playerId int, name VARCHAR(50), code VARCHAR(50), type VARCHAR(50), nomenclature VARCHAR(50), image Text)');
    await db.execute('CREATE TABLE IF NOT EXISTS players (id INTEGER, name VARCHAR(50), email VARCHAR(50), phone VARCHAR(20), telegram VARCHAR(50), urlCodeQr Text, reference VARCHAR(50), user VARCHAR(50), emailGame VARCHAR(50), wallet Text, accessToken Text, tokenFCM Text, dateClaim VARCHAR(20) )');
    await db.execute('CREATE TABLE IF NOT EXISTS slp (id INTEGER, playerId int, total INTEGER, daily INTEGER, createdAt VARCHAR(50), date VARCHAR(20))');
  }

  /*
    CRUD FUNCTION
  */

   // Delete service
  Future deleteAll() async{
    var dbConnection = await db;
    await dbConnection.execute('DROP TABLE IF EXISTS admin');
    await dbConnection.execute('DROP TABLE IF EXISTS animals');
    await dbConnection.execute('DROP TABLE IF EXISTS players');
    await dbConnection.execute('DROP TABLE IF EXISTS slp');
  
    onCreateFunc(dbConnection, versionDB);
  }

  // Get User
  Future <Admin> getAdmin() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM admin WHERE id = 1');
    Admin admin = new Admin();

    for(int i = 0; i< list.length; i++)
    {
      admin = Admin(
        accessToken : list[i]['accessToken'],
        tokenFCM : list[i]['tokenFCM'],
      );
    }

    return admin;
  }

  Future <Player> getPlayer(accessToken) async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM players WHERE accessToken = \'$accessToken\' ');
    Player player = new Player();

    for(int i = 0; i< list.length; i++)
    {
      player = Player(
        id : list[i]['id'],
        email : list[i]['email'],
        name : list[i]['name'],
        phone : list[i]['phone'],
        telegram : list[i]['telegram'],
        urlCodeQr : list[i]['urlCodeQr'],
        reference : list[i]['reference'],
        emailGame : list[i]['emailGame'],
        wallet : list[i]['wallet'],
        dateClaim: list[i]['dateClaim'],
        accessToken : list[i]['accessToken'],
        tokenFCM : list[i]['tokenFCM'],
        listSlp : await getSlp(list[i]['id']),
        listAnimals : await getAnimals(list[i]['id']),
      );
    }

    return player;
  }

  Future <List<Player>> getPlayers() async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM players');
    List<Player>listPlayers = [];
    Player player = new Player();

    for(int i = 0; i< list.length; i++)
    {
      player = Player(
        id : list[i]['id'],
        email : list[i]['email'],
        name : list[i]['name'],
        phone : list[i]['phone'],
        telegram : list[i]['telegram'],
        urlCodeQr : list[i]['urlCodeQr'],
        reference : list[i]['reference'],
        emailGame : list[i]['emailGame'],
        wallet : list[i]['wallet'],
        dateClaim: list[i]['dateClaim'],
        listSlp : await getSlp(list[i]['id']),
        listAnimals : await getAnimals(list[i]['id']),
      );

      listPlayers.add(player);
    }

    return listPlayers;
  }

  Future getSlp(idPlayer) async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM slp WHERE playerId = \'$idPlayer\' ');
    List<Slp>listslp = [];
    Slp slp = new Slp();

    for(int i = 0; i< list.length; i++)
    {
      slp = Slp(
        id : list[i]['id'],
        playerId : list[i]['playerId'],
        total : list[i]['total'],
        daily : list[i]['daily'],
        createdAt : list[i]['createdAt'],
        date : list[i]['date'],
      );

      listslp.add(slp);
    }

    return listslp;
  }

  Future getAnimals(idPlayer) async{
    var dbConnection = await db;

    List<Map> list = await dbConnection.rawQuery('SELECT * FROM animals WHERE playerId = \'$idPlayer\' ');
    List<Animal>listAnimals = [];
    Animal animal = new Animal();

    for(int i = 0; i< list.length; i++)
    {
      animal = Animal(
        id : list[i]['id'],
        playerId : list[i]['playerId'],
        name : list[i]['name'],
        code : list[i]['code'],
        type : list[i]['type'],
        nomenclature : list[i]['nomenclature'],
        image : list[i]['image'],

      );

      listAnimals.add(animal);
    }

    return listAnimals;
  }
  

  void createOrUpdateAdmin(Admin admin) async{
    var dbConnection = await db;

    String query = 'INSERT OR REPLACE INTO admin (id, accessToken, tokenFCM) VALUES ( (SELECT id FROM admin WHERE id = 1), \'${admin.accessToken}\', \'${admin.tokenFCM}\' )';
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }

  void createOrUpdateListPlayer(List<Player> listPlayers){
    for (var player in listPlayers) {
      createOrUpdatePlayer(player);
    }
  }

  void createOrUpdatePlayer(Player player) async{
    var dbConnection = await db;

    String query;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM players WHERE id = \'${player.id}\' ');
    
    if(list.length == 0)
      query = 'INSERT INTO players (id, email, name, phone, telegram, urlCodeQr, reference, emailGame, wallet, accessToken, tokenFCM, dateClaim) VALUES ( \'${player.id}\', \'${player.email}\', \'${player.name}\', \'${player.phone}\', \'${player.telegram}\', \'${player.urlCodeQr}\', \'${player.reference}\', \'${player.emailGame}\', \'${player.wallet}\', \'${player.accessToken}\', \'${player.tokenFCM}\', \'${player.dateClaim}\' )'; 
    else
      query = 'UPDATE players SET email=\'${player.email}\', name=\'${player.name}\', phone=\'${player.phone}\', telegram=\'${player.telegram}\', urlCodeQr=\'${player.urlCodeQr}\', reference=\'${player.reference}\', emailGame=\'${player.emailGame}\', wallet=\'${player.wallet}\', accessToken=\'${player.accessToken}\', tokenFCM=\'${player.tokenFCM}\', dateClaim=\'${player.dateClaim}\' WHERE id = \'${player.id}\' ';
    
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });

    createOrUpdateListSlp(player.listSlp!);
    createOrUpdateListAnimals(player.listAnimals!);
  }

  void createOrUpdateListSlp(List<Slp> listSlp){
    for (var slp in listSlp) {
      createOrUpdateSlp(slp);
    }
  }

  void createOrUpdateSlp(Slp slp) async{
    var dbConnection = await db;
    
    String query;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM slp WHERE id = \'${slp.id}\' ');
    
    if(list.length == 0)
      query = 'INSERT INTO slp (id, playerId, total, daily, createdAt, date) VALUES ( \'${slp.id}\', \'${slp.playerId}\', \'${slp.total}\', \'${slp.daily}\', \'${slp.createdAt}\', \'${slp.date}\' )';
    else
      query = 'UPDATE slp SET playerId=\'${slp.playerId}\', total=\'${slp.total}\', daily=\'${slp.daily}\', createdAt=\'${slp.createdAt}\', date=\'${slp.date}\' WHERE id = \'${slp.id}\' ';
    
    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }

  void createOrUpdateListAnimals(List<Animal> listAnimals){
    for (var animal in listAnimals) {
      createOrUpdateAnimal(animal);
    }
  }

  void createOrUpdateAnimal(Animal animal) async{
    var dbConnection = await db;

    String query;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM animals WHERE id = \'${animal.id}\' ');
    
    if(list.length == 0)
      query = 'INSERT INTO animals (id, playerId, name, code, type, nomenclature, image) VALUES ( \'${animal.id}\', \'${animal.playerId}\', \'${animal.name}\', \'${animal.code}\', \'${animal.type}\', \'${animal.nomenclature}\', \'${animal.image}\' )';
    else
      query = 'UPDATE animals SET playerId=\'${animal.playerId}\', name=\'${animal.name}\', code=\'${animal.code}\', type=\'${animal.type}\', nomenclature=\'${animal.nomenclature}\', image=\'${animal.image}\' WHERE id = \'${animal.id}\' ';
    

    await dbConnection.transaction((transaction) async{
      return await transaction.rawInsert(query);
    });
  }

}