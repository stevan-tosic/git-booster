#!/usr/bin/env bash


RCol='\e[0m'    # Text Reset

# Regular           Bold                Underline           High Intensity      BoldHigh Intens     Background
Bla='\e[0;30m';     BBla='\e[1;30m';    UBla='\e[4;30m';    IBla='\e[0;90m';    BIBla='\e[1;90m';   On_Bla='\e[40m';
Red='\e[0;31m';     BRed='\e[1;31m';    URed='\e[4;31m';    IRed='\e[0;91m';    BIRed='\e[1;91m';   On_Red='\e[41m';
Gre='\e[0;32m';     BGre='\e[1;32m';    UGre='\e[4;32m';    IGre='\e[0;92m';    BIGre='\e[1;92m';   On_Gre='\e[42m';
Yel='\e[0;33m';     BYel='\e[1;33m';    UYel='\e[4;33m';    IYel='\e[0;93m';    BIYel='\e[1;93m';   On_Yel='\e[43m';
Blu='\e[0;34m';     BBlu='\e[1;34m';    UBlu='\e[4;34m';    IBlu='\e[0;94m';    BIBlu='\e[1;94m';   On_Blu='\e[44m';
Pur='\e[0;35m';     BPur='\e[1;35m';    UPur='\e[4;35m';    IPur='\e[0;95m';    BIPur='\e[1;95m';   On_Pur='\e[45m';
Cya='\e[0;36m';     BCya='\e[1;36m';    UCya='\e[4;36m';    ICya='\e[0;96m';    BICya='\e[1;96m';   On_Cya='\e[46m';
Whi='\e[0;37m';     BWhi='\e[1;37m';    UWhi='\e[4;37m';    IWhi='\e[0;97m';    BIWhi='\e[1;97m';   On_Whi='\e[47m';

#
# Runs checks
#
function F_RUN_GIT_SETUP
{
    clear
    F_CHECK_GIT_INSTALLATION
    F_CHECK_GIT_EMAIL
    F_CHECK_GIT_NAME
    F_ADD_ALIASES
}

#
# Checks if Git is installed
#
function F_CHECK_GIT_INSTALLATION
{
    echo -e "\n${Cya}Cheking git installation...${RCol}\n\n"
    VERSION=$(git --version)

    VERSION_STRING=${VERSION:0:11}

    if [ "$VERSION_STRING" == "git version" ]
    then
        echo -e "Git is installed"
    else
        echo -e "${Red}Git is not installed ${RCol}\n"
        exit
    fi

}

#
# Checks if Git email is set
#
function F_CHECK_GIT_EMAIL
{
    echo -e "\n\n\n${Cya}Cheking git global email...${RCol}\n\n"
    EMAIL=$(git config user.email)

    echo "$EMAIL"

    if [ "$EMAIL" == "" ]
    then
	    echo -e "Do you want to add email? ${Cya}[Y/n]${RCol}"
        read ANSWER

    if [ "$ANSWER" == "Y" ] || [ "$ANSWER" == "y" ]
    then
         while true
         do
                read -p "Enter email: " email
                if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$ ]]
                then
                    echo "Email address $email is valid."
                    F_ADD_GIT_EMAIL "$email"
                    break
                else
                    echo "Email address $email is invalid."
                fi
         done
    fi
    exit
    fi
}

#
# Checks if Git name is set
#
function F_CHECK_GIT_NAME
{
    echo -e "\n\n\n${Cya}Cheking git global name...${RCol}\n\n"
    NAME=$(git config user.name)

    echo -e "$NAME\n"

    if [ "$NAME" == "" ]
    then
	    echo -e "Do you want to add name? ${Cya}[Y/n]${RCol}"
        read ANSWER

    if [ "$ANSWER" == "Y" ] || [ "$ANSWER" == "y" ]
    then
         while true
         do
                read -p "Enter name: " name
                F_ADD_GIT_NAME "$name"
         done
    fi
    exit
    fi
}

#
# Adds Git global name
#
function F_ADD_GIT_NAME
{
	    echo -e "Adding git name..."
	    git config --global user.name ${1}

	    NAME=$(git config user.name)
	    if [ "$NAME" == ${1} ]
	    then
	       echo -e "Name $NAME is added"
	    fi
}

#
# Adds Git global email
#
function F_ADD_GIT_EMAIL
{
        echo -e "Adding git email..."
	    git config --global user.email ${1}

	    EMAIL=$(git config user.email)
	    if [ "$EMAIL" == ${1} ]
	    then
	       echo -e "Email address $EMAIL is added"
	    fi
}

#
# Adds Git aliases
#
function F_ADD_ALIASES
{
    echo -e "\nAdding git aliases...\n\n"

    git config --global alias.ch checkout
    git config --global alias.b branch
    git config --global alias.s status
    git config --global alias.l "log --graph --oneline --decorate"

    echo -e "Aliases added\n\n"

}

#
# Prints error message
#
function F_ERROR_MESSAGE
{
	echo -e "\n"
	echo -e "${BRed}ERROR: ${1}${RCol}"
	echo -e "\n"
}

F_RUN_GIT_SETUP