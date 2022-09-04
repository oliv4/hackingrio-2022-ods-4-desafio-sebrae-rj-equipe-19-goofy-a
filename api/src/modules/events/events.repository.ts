import { EntityRepository, MoreThan, Repository } from 'typeorm';
import { EventsEntity } from './events.entity';

@EntityRepository(EventsEntity)
export class EventsRepository extends Repository<EventsEntity> {
  public async findAllActiveEvents(): Promise<EventsEntity[]> {
    const events = this.find({
      where: {
        isActive: true,
        finishedAt: MoreThan(new Date()),
      },
    });
    return events;
  }
  public async getEventByQuizId(quizId: string): Promise<EventsEntity> {
    return this.createQueryBuilder('event')
      .innerJoin('event-challenges', 'ec', 'event.id = ec.event_id')
      .innerJoin('quiz', 'qz', 'qz.id = ec.challenge_id')
      .where('qz.id = :quizId', { quizId })
      .getOne();
  }
}
