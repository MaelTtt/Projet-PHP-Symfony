<?php

namespace App\Controller;

use App\Entity\Evenement;
use App\Form\EvenementType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use App\Repository\EvenementRepository;
use Knp\Component\Pager\PaginatorInterface;

class EvenementController extends AbstractController
{
    #[Route('/evenement/new', name: 'evenement_new')]
    public function new(Request $request, EntityManagerInterface $entityManager): Response
    {
        $evenement = new Evenement();
        $form = $this->createForm(EvenementType::class, $evenement);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $entityManager->persist($evenement);
            $entityManager->flush();

            return $this->redirectToRoute('evenement_list');
        }

        return $this->render('evenement/new.html.twig', [
            'form' => $form->createView(),
        ]);
    }

    #[Route('/evenement', name: 'evenement_list')]
    public function list(EvenementRepository $evenementRepository, PaginatorInterface $paginator, Request $request): Response
    {
        $queryBuilder = $evenementRepository->createQueryBuilder('e');

        $pagination = $paginator->paginate(
            $queryBuilder->getQuery(),
            $request->query->getInt('page', 1),
            10
        );

        return $this->render('evenement/list.html.twig', [
            'pagination' => $pagination,
        ]);
    }

    #[Route('/evenement/{id}', name: 'evenement_show')]
    public function show(Evenement $evenement): Response
    {
        $this->denyAccessUnlessGranted('view', $evenement);

        return $this->render('evenement/show.html.twig', [
            'event' => $evenement,
        ]);
    }
}
