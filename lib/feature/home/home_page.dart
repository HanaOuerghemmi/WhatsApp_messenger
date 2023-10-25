import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:whatsapp_messenger/feature/auth/controller/auth_controller.dart';
import 'package:whatsapp_messenger/feature/auth/widgets/custom_icon.dart';
import 'package:whatsapp_messenger/feature/home/call_home_page.dart';
import 'package:whatsapp_messenger/feature/home/chat_home_page.dart';
import 'package:whatsapp_messenger/feature/home/status_home_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
 late Timer timer;

 updatedUserPresence(){
  ref.read(authControllerProvider).updateUserPresence();
 }

  @override

  void initState(){
    
    updatedUserPresence();
    timer =
      Timer.periodic(Duration(minutes: 1), (
      timer)=> setState(() { }),
      );
    super.initState();
  }

@override
  void dispose() {
    timer.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('WhatsApp', style: TextStyle(letterSpacing: 1),),
          elevation: 1,
          actions: [
            CustomIconButton(
              onTap: (){}, 
              icon: Icons.search
              ),
              CustomIconButton(
              onTap: (){}, 
              icon: Icons.more_vert
              ),
          ],
          bottom: const TabBar(
            indicatorWeight: 3,
            labelStyle: TextStyle(
              fontWeight: FontWeight.bold,
            ),
            splashFactory: NoSplash.splashFactory,
            tabs: [
              Tab(text:'CHATS'),
              Tab(text:'STATUS'),
              Tab(text:'CALLS'),
            ]
            
            ),
          ),
          body: TabBarView(children: [
            ChatHomePage(),
            StatusHomePage(),
            CallHomePage(),
          ]) ,
          
          ),
      
      );
  }
}