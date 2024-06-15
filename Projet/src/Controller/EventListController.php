<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class EventListController extends AbstractController
{
    #[Route('/event/list', name: 'event_list')]
    public function index(): Response
    {
        return $this->render('event_list/index.html.twig', [
            'controller_name' => 'EventListController',
        ]);
    }
}
