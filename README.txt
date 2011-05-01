"LOREM IPSUM, OVERWRITE WITH MEANINGFUL INFO AFTER READING"

Launching it
============

The first thing you want to do is choose which buildout to run. We provide two
buildouts, each with a PIL variant:

* Developement

* Production

The PIL variants (suffix ``+pil.cfg``) differ from the original in that they
will pull down and install, buildout-locally, a PIL egg, hence making the
installation (globally o through virtualenv) of a PIL optional.

.. warning:: You should not use the PIL variant if you have PIL installed
   globally or via virtualenv as this might cause conflicts.

When to use one or the other depends on wether you plan to run it locally to
develop on it or you are working on a server: use ``developement.cfg`` (or
``developement+pil.cfg``) in the first case and ``production.cfg`` (or
``production+pil.cfg``) in the latter.

The developement buildout is rather straightforward and I will not comment
about it, while the production buildout is somewhat more complex.

First of all it creates:

* A main instance (``main-instance``) running on port 8080

* A debug instance (``debug-instance``) running on port 8081, not activated by
  default, with verbose security and the products ``Products.PDBDebugMode``,
  ``Products.PrintingMailHost`` and ``teamrubber.theoracle``. This should be
  activated in foreground mode when needed.

* A zeo server (``zeo-server``)

* A recipe to set up commands to do backups (``backup``)

* Several recipes to create specific files into the ``build`` directory which
  deal with logrotation and cron scripts. This should then be installed in the
  correct directories (the system global ``/etc/logrotate.d``, for example).
  Inside the ``build`` directory, the structure of the root is mimicked (for
  the relevant parts).

* The tasks ``logrotate``, ``backup-task`` and ``pack-task`` create
  respectively a logrotate (global) script, a daily incremental backup task
  (using settings from ``backup``) and a snapshot and pack weekly task.

Make sure to review and understand the buildout before launching it.

IMPORTANT!!! How to use this bo
--------------------
For developers:
You only have to deal with base and developement profiles. 
First of all checkout this bo with:

git clone git://git.abstract.it/abstract-collective/abstract-buildout.git <your_project_name>  

and switch to your plone version related branch(3.x is the default branch):

i.e.: 
git pull origin 4.x:4.x
git checkout 4.x

Please always use the fetch URL so you can safely make mistakes without break the original bo

Go in <your_project_name> folder and execute this steps:

1) Remove the remote origin:

git remove rm origin

2) Create <you_project> on Gitorius (git.abstract.it)

3) Add the "buildout" repository in <your_project>   

4) Add the "buildout" repository just created as the new origin of your project:

git remote add origin <your_buildout_repository_push_url>

5) Push 

git push origin master


Use Mr.Develop to handle your develop eggs.     
-------------------------------------------

Put the "stable products" (i.e. eggs from cheeseshop) in the eggs/zcml variable of the base.cfg  
For new products put the pinned verision in versions/base-versions.cfg

Put your develop eggs in the [sources] part of the development.cfg      
For new products put the pinned verision in versions/development-versions.cfg

Make a branch of you eggs when you are ready to deploy and use it in the [sources] part of the production cfg

For SysAdmin:
In the production.cfg profile make sure all parameters are good. 

Change the 

[project] 
name = project_name

whith the real project name 
